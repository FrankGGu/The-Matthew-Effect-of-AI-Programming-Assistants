#lang racket

(define (split-array-with-same-average nums)
  (define n (length nums))
  (define sum (apply + nums))
  (define (valid? k)
    (define target (* sum k))
    (define (dp i j t)
      (cond [(= j 0) #t]
            [(= i n) #f]
            [else
             (or (dp (+ i 1) j t)
                 (and (>= t (list-ref nums i))
                      (dp (+ i 1) (- j 1) (- t (list-ref nums i)))))]))
    (dp 0 k 0))
  (define (check k)
    (and (<= k n)
         (<= (* k sum) (* sum k))
         (valid? k)))
  (for/or ([k (in-range 1 (add1 (quotient n 2)))])
    (check k)))