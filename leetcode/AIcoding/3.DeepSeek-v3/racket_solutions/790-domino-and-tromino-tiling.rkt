#lang racket

(define (num-tilings n)
  (define mod 1000000007)
  (cond
    [(= n 1) 1]
    [(= n 2) 2]
    [(= n 3) 5]
    [else
     (let loop ([i 4]
                [dp1 1]   ; dp[i-3]
                [dp2 2]   ; dp[i-2]
                [dp3 5])   ; dp[i-1]
       (if (> i n)
           dp3
           (let ([dp4 (modulo (+ (* 2 dp3) dp1) mod)])
             (loop (add1 i) dp2 dp3 dp4))))]))