#lang racket

(require data/heap)
(require data/skiplist)

(define (find-servers-that-handled-most-number-of-requests k requests)
  (define server-counts (make-vector k 0))
  ;; busy-servers stores (cons finish-time server-idx)
  ;; It's a min-heap ordered by finish-time
  (define busy-servers (make-heap (lambda (a b) (< (car a) (car b)))))

  ;; free-servers stores server-idx
  ;; It's a skiplist for efficient ordered lookup and removal
  (define free-servers (make-skiplist <))
  (for ([i (in-range k)])
    (skiplist-add! free-servers i))

  (for ([i (in-range (length requests))]
        [request (in-list requests)])
    (define arrival-time (car request))
    (define end-time (cadr request))

    ;; Release busy servers that are now free
    (while (and (not (heap-empty? busy-servers))
                (<= (car (heap-min busy-servers)) arrival-time))
      (define min-element (heap-extract-min! busy-servers))
      (define server-idx (cdr min-element))
      (skiplist-add! free-servers server-idx))

    (define assigned-server-idx #f)
    (define target-server-idx (modulo i k))

    ;; Try to find a server >= target-server-idx
    (define-values (found-geq-server-idx found-node) (skiplist-find-next-geq free-servers target-server-idx))

    (when found-geq-server-idx
      (set! assigned-server-idx found-geq-server-idx))

    ;; If no server >= target-server-idx, try to find the smallest server (wrap around)
    (unless assigned-server-idx
      (when (not (skiplist-empty? free-servers))
        (set! assigned-server-idx (skiplist-min free-servers))))

    ;; If a server is assigned, handle the request
    (when assigned-server-idx
      (skiplist-remove! free-servers assigned-server-idx)
      (heap-add! busy-servers (cons end-time assigned-server-idx))
      (vector-set! server-counts assigned-server-idx
                   (+ (vector-ref server-counts assigned-server-idx) 1)))
    ) ;; end for requests

  ;; Find the maximum number of requests handled
  (define max-handled 0)
  (for ([count (in-vector server-counts)])
    (set! max-handled (max max-handled count)))

  ;; Collect all servers that handled the maximum number of requests
  (define result '())
  (for ([i (in-range k)])
    (when (= (vector-ref server-counts i) max-handled)
      (set! result (cons i result))))

  (sort result <))