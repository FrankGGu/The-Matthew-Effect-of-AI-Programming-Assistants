#lang racket

(define (beautiful-towers heights)
  (define n (length heights))
  (define left (make-vector n 0))
  (define right (make-vector n 0))
  (for ([i (in-range n)])
    (when (> i 0)
      (vector-set! left i (+ (vector-ref left (sub1 i)) (if (> (list-ref heights i) (list-ref heights (sub1 i))) 1 0)))))
  (for ([i (in-range (sub1 n) -1 -1)])
    (vector-set! right i (+ (vector-ref right (add1 i)) (if (> (list-ref heights i) (list-ref heights (add1 i))) 1 0))))
  (for/sum ([i (in-range n)]) (+ (vector-ref left i) (vector-ref right i)))
  )