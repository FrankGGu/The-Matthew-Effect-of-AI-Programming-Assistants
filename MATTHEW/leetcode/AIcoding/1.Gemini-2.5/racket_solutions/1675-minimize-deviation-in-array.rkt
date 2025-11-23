#lang racket

(require data/heap)

(define (minimize-deviation nums)
  (define pq (make-heap >)) ; Max-heap, using > as comparator
  (define current-min-in-pq +inf.0)

  (for ([num nums])
    (let ([val (if (odd? num) (* num 2) num)])
      (heap-insert! pq val)
      (set! current-min-in-pq (min current-min-in-pq val))))

  (define min-deviation +inf.0)

  (let loop ()
    (define max-val (heap-min pq))
    (set! min-deviation (min min-deviation (- max-val current-min-in-pq)))

    (heap-remove-min! pq)

    (when (even? max-val)
      (define new-val (/ max-val 2))
      (heap-insert! pq new-val)
      (set! current-min-in-pq (min current-min-in-pq new-val))
      (loop)))

  min-deviation)