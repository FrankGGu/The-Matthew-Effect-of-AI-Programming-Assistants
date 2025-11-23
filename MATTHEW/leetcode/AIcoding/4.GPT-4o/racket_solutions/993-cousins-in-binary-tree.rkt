#lang racket

(struct tree (val left right))

(define (isCousins root x y)
  (define (dfs node parent depth value)
    (if (null? node)
        (values #f #f)
        (let-values ([(found? d) (if (= (tree-val node) value)
                                      (values #t depth)
                                      (dfs (tree-left node) node (+ depth 1) value)])
                     [(found?2 d2) (if found?
                                      (values found? d)
                                      (dfs (tree-right node) node (+ depth 1) value))])
          (values (or found? found?2) d)))
  (define (find-depth x y)
    (let-values ([(found-x depth-x) (dfs root #f 0 x)]
                 [(found-y depth-y) (dfs root #f 0 y)])
      (and found-x found-y (= depth-x depth-y) (not (= (tree-val parent) (tree-val (if found-x found-y found-x))))))
  (find-depth x y))