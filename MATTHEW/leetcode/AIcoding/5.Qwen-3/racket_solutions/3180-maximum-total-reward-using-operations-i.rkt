#lang racket

(define (maximum-total-reward nums)
  (define (dfs i s)
    (cond [(= i (length nums)) s]
          [else
           (let ([n (list-ref nums i)])
             (if (>= n s)
                 (max (dfs (+ i 1) s) (dfs (+ i 1) (+ s n)))
                 (dfs (+ i 1) s)))]))
  (dfs 0 0))