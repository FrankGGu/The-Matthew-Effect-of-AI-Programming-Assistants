#lang racket

(define (eat-pizzas a b c k)
  (define INF (add1 k)) ; A value larger than any possible valid number of pizzas
  (define dp (make-vector (add1 k) INF))

  (vector-set! dp 0 0) ; Base case: 0 slices requires 0 pizzas

  (for ([i (in-range 1 (add1 k))])
    (when (>= i a)
      (vector-set! dp i (min (vector-ref dp i) (add1 (vector-ref dp (- i a))))))
    (when (>= i b)
      (vector-set! dp i (min (vector-ref dp i) (add1 (vector-ref dp (- i b))))))
    (when (>= i c)
      (vector-set! dp i (min (vector-ref dp i) (add1 (vector-ref dp (- i c)))))))

  (let ([result (vector-ref dp k)])
    (if (= result INF)
        -1
        result)))