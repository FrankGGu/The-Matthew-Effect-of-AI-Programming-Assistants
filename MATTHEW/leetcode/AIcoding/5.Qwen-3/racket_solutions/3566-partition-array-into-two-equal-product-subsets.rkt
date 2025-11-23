#lang racket

(define (can-divide? nums)
  (define n (length nums))
  (define total-product (apply * nums))
  (define target (sqrt total-product))
  (define (dfs i product seen)
    (cond [(= i n) (= product 1)]
          [else
           (if (member i seen)
               (dfs (add1 i) product seen)
               (or (dfs (add1 i) (* product (list-ref nums i)) (cons i seen))
                   (dfs (add1 i) product seen)))]))
  (and (integer? target) (not (negative? target)) (dfs 0 1 '())))

(define/contract (can-partition nums)
  (-> (listof exact-integer?) boolean?)
  (can-divide? nums))