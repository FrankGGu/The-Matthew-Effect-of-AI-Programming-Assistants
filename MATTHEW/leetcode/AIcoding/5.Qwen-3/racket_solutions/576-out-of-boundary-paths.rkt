#lang racket

(define (find-number-of-ways n m max_steps start_row start_col)
  (define mod 1000000007)
  (define dp (make-hash))
  (define (key r c s) (cons (cons r c) s))
  (define (dfs r c s)
    (cond [(and (< r 0) (< c 0)) 0]
          [(and (>= r n) (>= c m)) 0]
          [(and (<= r n) (<= c m) (or (< r 0) (< c 0) (>= r n) (>= c m))) 1]
          [(> s max_steps) 0]
          [else
           (hash-ref dp (key r c s) (lambda ()
                                     (let ([res (+ (dfs (add1 r) c (add1 s))
                                                   (dfs (sub1 r) c (add1 s))
                                                   (dfs r (add1 c) (add1 s))
                                                   (dfs r (sub1 c) (add1 s)))]
                                       (hash-set! dp (key r c s) res)
                                       (modulo res mod))))]))
  (dfs start_row start_col 0))