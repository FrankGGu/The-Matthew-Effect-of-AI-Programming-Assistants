#lang racket

(define (min-depth root)
  (cond [(not root) 0]
        [(and (not (car root)) (not (cadr root))) 1]
        [(not (car root)) (add1 (min-depth (cadr root)))]
        [(not (cadr root)) (add1 (min-depth (car root)))]
        [else (add1 (min (min-depth (car root)) (min-depth (cadr root))))]))