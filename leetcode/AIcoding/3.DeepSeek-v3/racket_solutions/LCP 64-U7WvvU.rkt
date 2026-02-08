#lang racket

(define (min-camera-cover root)
  (define (helper node)
    (if (null? node)
        (list 1 0 0)
        (let* ([left (helper (car node))]
               [right (helper (cdr node))]
               [min-left (min (list-ref left 0) (list-ref left 1))]
               [min-right (min (list-ref right 0) (list-ref right 1))]
               [d0 (+ (list-ref left 1) (list-ref right 1))]
               [d1 (min (+ (list-ref left 0) (min-right))
                         (+ (min-left) (list-ref right 0)))]
               [d2 (+ 1 (min (list-ref left 0) (list-ref left 1))
                         (min (list-ref right 0) (list-ref right 1)))])
          (list d0 d1 d2))))
  (let ([res (helper root)])
    (min (list-ref res 1) (list-ref res 2))))