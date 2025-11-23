#lang racket

(define (maximum-value-sum nums)
  (define n (length nums))
  (define dp (make-vector n #f))
  (define (dfs i)
    (if (>= i n) 0
        (if (vector-ref dp i)
            (vector-ref dp i)
            (let ((res (if (= (bitwise-and (list-ref nums i) 1) 1)
                           (+ (list-ref nums i) (dfs (+ i 1)))
                           (dfs (+ i 1)))))
              (vector-set! dp i res)
              res))))
  (dfs 0))