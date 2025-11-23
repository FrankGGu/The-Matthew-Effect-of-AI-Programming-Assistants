#lang racket

(define (paint-fence n k)
  (if (< n 1) 0
      (if (= n 1) k
          (let ([a (if (= n 2) k (* k (- k 1)))]
                [b (if (= n 2) (- k 1) (* (- k 1) (- k 1)))])
            (+ a b)))))