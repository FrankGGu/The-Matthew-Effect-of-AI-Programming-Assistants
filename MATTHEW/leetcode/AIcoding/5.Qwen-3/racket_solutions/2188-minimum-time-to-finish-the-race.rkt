#lang racket

(define (minimum-time-2023-10-14 race-time)
  (define (dfs i j)
    (cond [(= i (vector-length race-time)) 0]
          [(and (= j 0) (< i (vector-length race-time)))
           (+ (vector-ref race-time i) (dfs (add1 i) 1))]
          [else
           (min (+ (vector-ref race-time i) (dfs (add1 i) 1))
                (if (= j 1)
                    (dfs (add1 i) 0)
                    (dfs (add1 i) 0)))]))
  (dfs 0 0))