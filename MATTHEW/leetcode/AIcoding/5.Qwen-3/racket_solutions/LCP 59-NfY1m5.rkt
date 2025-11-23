#lang racket

(define (can-cross stones)
  (define n (length stones))
  (define dp (make-vector n #f))
  (vector-set! dp 0 #t)
  (for ([i (in-range n)])
    (when (vector-ref dp i)
      (for ([j (in-range (add1 i) n)])
        (when (<= (abs (- (list-ref stones i) (list-ref stones j))) 2)
          (vector-set! dp j #t)))))
  (vector-ref dp (sub1 n)))