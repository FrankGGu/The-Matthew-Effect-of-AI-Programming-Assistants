#lang racket

(define (tree-depth root)
  (if (null? root)
      0
      (add1 (max (tree-depth (car (cdr root))) (tree-depth (car (cdr (cdr root))))))))