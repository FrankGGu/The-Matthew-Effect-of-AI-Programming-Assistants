#lang racket

(define (max-path-sum root)
  (define max-sum -inf.0)

  (define (helper node)
    (if (null? node)
        0
        (let* ([left (max (helper (list-ref node 1)) 0)]
               [right (max (helper (list-ref node 2)) 0)]
               [current (+ (list-ref node 0) left right)])
          (set! max-sum (max max-sum current))
          (+ (list-ref node 0) (max left right))))

  (helper root)
  max-sum)