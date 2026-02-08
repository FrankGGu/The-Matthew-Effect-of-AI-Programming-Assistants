#lang racket

(require data/heap)

(define (take-gifts piles k)
  (define h (make-heap >))

  (for-each (lambda (pile) (heap-add! h pile)) piles)

  (for ([_ (in-range k)])
    (when (not (heap-empty? h))
      (define current-max (heap-extract-max! h))
      (define new-val (floor (sqrt current-max)))
      (heap-add! h new-val)))

  (for/sum ([item (in-heap h)])
    item))