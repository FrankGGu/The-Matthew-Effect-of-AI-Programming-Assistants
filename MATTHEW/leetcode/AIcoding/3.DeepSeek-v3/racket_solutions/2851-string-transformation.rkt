#lang racket

(define (can-transform start end)
  (let loop ([i 0] [j 0] [n (string-length start)] [m (string-length end)])
    (cond
      [(and (>= i n) (>= j m)) #t]
      [(or (>= i n) (>= j m)) #f]
      [else
       (let ([c1 (string-ref start i)]
             [c2 (string-ref end j)])
         (cond
           [(char=? c1 c2) (loop (add1 i) (add1 j) n m)]
           [(char=? c1 #\X) (loop (add1 i) j n m)]
           [(char=? c2 #\X) (loop i (add1 j) n m)]
           [else #f]))])))