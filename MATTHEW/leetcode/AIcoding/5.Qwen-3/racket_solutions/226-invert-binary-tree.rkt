#lang racket

(define (invert-tree root)
  (cond [(not root) #f]
        [else
         (let ([left (invert-tree (car (cdr root)))]
               [right (invert-tree (car (cdr (cdr root))))])
           (list (car root) right left))]))