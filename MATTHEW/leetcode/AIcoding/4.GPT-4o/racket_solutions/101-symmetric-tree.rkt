#lang racket

(define (isSymmetric root)
  (define (isMirror t1 t2)
    (cond
      [(and (null? t1) (null? t2)) #t]
      [(or (null? t1) (null? t2)) #f]
      [else (and (= (tree-val t1) (tree-val t2))
                 (isMirror (tree-left t1) (tree-right t2))
                 (isMirror (tree-right t1) (tree-left t2)))]))
  (isMirror root root))