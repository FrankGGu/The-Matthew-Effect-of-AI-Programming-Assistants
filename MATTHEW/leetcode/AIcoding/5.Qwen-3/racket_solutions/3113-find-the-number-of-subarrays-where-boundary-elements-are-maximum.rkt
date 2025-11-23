#lang racket

(define (num-subarrays nums)
  (define n (length nums))
  (define result 0)
  (define (is-boundary-max i j)
    (and (<= i j)
         (= (list-ref nums i) (apply max (take-right nums (- j i + 1))))
         (= (list-ref nums j) (apply max (take nums (+ j 1))))))
  (for ([i (in-range n)])
    (for ([j (in-range i n)])
      (when (is-boundary-max i j)
        (set! result (+ result 1)))))
  result)