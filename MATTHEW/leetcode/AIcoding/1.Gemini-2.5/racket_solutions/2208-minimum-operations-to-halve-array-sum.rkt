#lang racket
(require data/heap)

(define (min-operations-to-halve-array-sum nums)
  (let* ([initial-sum (for/sum ([n nums]) (exact->inexact n))]
         [target-sum (/ initial-sum 2.0)]
         [pq (make-heap)]
         [current-sum initial-sum])

    (for-each (lambda (n) (heap-add! pq (- (exact->inexact n)))) nums)

    (let loop ([operations 0] [current-total current-sum])
      (if (<= current-total target-sum)
          operations
          (let* ([neg-max-val (heap-extract-min! pq)]
                 [max-val (- neg-max-val)]
                 [new-val (/ max-val 2.0)]
                 [reduced-amount (- max-val new-val)])
            (heap-add! pq (- new-val))
            (loop (+ operations 1) (- current-total reduced-amount)))))))