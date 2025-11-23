#lang racket

(define (reorganize-string s)
  (define freq (make-hash))
  (for ([c s])
    (hash-set! freq c (+ 1 (hash-ref freq c 0))))

  (define pq (priority-queue #:priority <))
  (for ([k (in-hash-keys freq)])
    (priority-queue-add! pq (cons (- (hash-ref freq k)) k)))

  (define result '())
  (let loop ()
    (when (not (priority-queue-empty? pq))
      (define-values (cnt1 c1) (priority-queue-remove! pq))
      (set! result (cons c1 result))
      (when (not (priority-queue-empty? pq))
        (define-values (cnt2 c2) (priority-queue-remove! pq))
        (set! result (cons c2 result))
        (when (> (+ cnt2 1) 0)
          (priority-queue-add! pq (cons (+ cnt2 1) c2))))
      (when (> (+ cnt1 1) 0)
        (priority-queue-add! pq (cons (+ cnt1 1) c1))))
    (loop))
  (list->string (reverse result)))

(define (distant-barcodes barcodes)
  (reorganize-string barcodes))