#lang racket

(define/contract (max-depth s)
  (-> string? exact-integer?)
  (let loop ([s s] [depth 0] [max-depth 0])
    (cond
      [(empty? s) max-depth]
      [(char=? #\() (loop (cdr s) (+ depth 1) (max max-depth (+ depth 1)))]
      [(char=? #\)) (loop (cdr s) (- depth 1) max-depth)]
      [else (loop (cdr s) depth max-depth)])))