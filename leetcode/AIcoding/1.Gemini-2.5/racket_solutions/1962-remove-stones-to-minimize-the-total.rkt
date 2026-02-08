#lang racket

(require data/heap)

(define (min-stone-sum piles k)
  (define h (make-heap >))

  (for-each (lambda (p) (heap-add! h p)) piles)

  (for ([_ (in-range k)])
    (when (not (heap-empty? h))
      (define current-max (heap-extract-max! h))
      (define new-val (- current-max (floor (/ current-max 2))))
      (heap-add! h new-val)))

  (define total-sum 0)
  (while (not (heap-empty? h))
    (set! total-sum (+ total-sum (heap-extract-max! h))))
  total-sum)