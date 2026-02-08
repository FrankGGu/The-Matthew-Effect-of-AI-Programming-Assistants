#lang racket

(require data/heap)

(define (maximum-number-of-points grid queries)
  (define m (vector-length grid))
  (define n (vector-length (vector-ref grid 0)))

  (define ans (make-vector (vector-length queries) 0))

  (define indexed-queries
    (for/list ([q (in-vector queries)]
               [idx (in-range (vector-length queries))])
      (list q idx)))
  (define sorted-queries (sort indexed-queries < #:key car))

  (define pq (make-heap (lambda (a b) (< (car a) (car b)))))

  (define visited
    (build-vector m (lambda (i) (build-vector n (lambda (j) #f)))))

  (define current-points 0)

  (define dr '(-1 1 0 0))
  (define dc '(0 0 -1 1))

  (heap-add! pq (list (vector-ref (vector-ref grid 0) 0) 0 0))
  (vector-set! (vector-ref visited 0) 0 #t)

  (for-each (lambda (query-pair)
              (define query-val (car query-pair))
              (define original-index (cadr query-pair))

              (let loop ()
                (when (and (not (heap-empty? pq))
                           (< (car (heap-min pq)) query-val))
                  (define cell (heap-extract-min! pq))
                  (define r (cadr cell))
                  (define c (caddr cell))

                  (set! current-points (+ current-points 1))

                  (for ([k (in-range 4)])
                    (define nr (+ r (list-ref dr k)))
                    (define nc (+ c (list-ref dc k)))

                    (when (and (>= nr 0) (< nr m)
                               (>= nc 0) (< nc n)
                               (not (vector-ref (vector-ref visited nr) nc)))
                      (vector-set! (vector-ref visited nr) nc #t)
                      (heap-add! pq (list (vector-ref (vector-ref grid nr) nc) nr nc))))
                  (loop))))

              (vector-set! ans original-index current-points))
            sorted-queries)

  ans)