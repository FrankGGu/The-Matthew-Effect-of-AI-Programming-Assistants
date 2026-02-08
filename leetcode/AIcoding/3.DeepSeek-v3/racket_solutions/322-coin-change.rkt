#lang racket

(define/contract (coin-change coins amount)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (define dp (make-vector (+ amount 1) +inf.0))
  (vector-set! dp 0 0)
  (for ([i (in-range 1 (+ amount 1))])
    (for ([coin (in-list coins)])
      (when (>= i coin)
        (vector-set! dp i (min (vector-ref dp i)
                               (+ (vector-ref dp (- i coin)) 1))))))
  (if (= (vector-ref dp amount) +inf.0) -1 (vector-ref dp amount)))