#lang racket

(define (length-of-longest-valid-obstacle-course-at-each-position obstacles)
  (define n (length obstacles))
  (define res (make-vector n 0))
  (define dp (list))
  (for ([i (in-range n)])
    (define val (list-ref obstacles i))
    (define idx (binary-search dp val))
    (if (= idx (length dp))
        (begin
          (vector-set! res i (+ idx 1))
          (set! dp (append dp (list val))))
        (begin
          (vector-set! res i (+ idx 1))
          (list-set! dp idx val))))
  res)

(define (binary-search lst target)
  (define (helper low high)
    (cond [(> low high) low]
          [else
           (define mid (quotient (+ low high) 2))
           (if (<= (list-ref lst mid) target)
               (helper (+ mid 1) high)
               (helper low (- mid 1)))]))
  (helper 0 (- (length lst) 1)))