#lang racket

(define (largest-component-size nums)
  (define max-num (apply max nums))
  (define parent (make-vector (+ max-num 1) -1))

  (define (find u)
    (if (= (vector-ref parent u) -1)
        u
        (let ([p (find (vector-ref parent u))])
          (vector-set! parent u p)
          p)))

  (define (union u v)
    (let ([pu (find u)]
          [pv (find v)])
      (unless (= pu pv)
        (vector-set! parent pv pu))))

  (for ([num nums])
    (for ([i (in-range 2 (add1 (integer-sqrt num)))])
      (when (zero? (remainder num i))
        (union num i)
        (union num (quotient num i))))))

  (define count (make-hash))
  (for ([num nums])
    (let ([p (find num)])
      (hash-update! count p add1 (λ () 0))))

  (if (hash-empty? count)
      0
      (apply max (hash-values count))))