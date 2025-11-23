#lang racket

(define (make-tree nodes)
  (if (null? nodes)
      #f
      (let ([val (car nodes)]
            [left (make-tree (cddr nodes))]
            [right (make-tree (cdddr nodes))])
        (cons val (cons left right)))))

(define (find-elements root)
  (define seen (mutable-set))
  (define (dfs node)
    (when node
      (set-add! seen (car node))
      (dfs (cadr node))
      (dfs (caddr node))))
  (dfs root)
  (lambda (target) (set-member? seen target)))

(define (main)
  (define root (make-tree '(1 #f #f)))
  (define obj (find-elements root))
  (displayln (obj 1))
  (displayln (obj 2)))

(main)