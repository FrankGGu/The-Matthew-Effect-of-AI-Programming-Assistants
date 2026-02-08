#lang racket

(define (max-sum-bst root)
  (define (helper node)
    (if (null? node)
        (list #t +inf.0 -inf.0 0) ; isBST, min, max, sum
        (let* ([left (helper (node-left node))]
               [right (helper (node-right node))]
               [val (node-val node)]
               [is-bst (and (car left) (car right)
                            (< (caddr left) val)
                            (> (cadr right) val))]
               [sum (if is-bst
                        (+ val (cadddr left) (cadddr right))
                        -inf.0)]
               [min-val (min val (cadr left))]
               [max-val (max val (caddr right))])
          (list is-bst min-val max-val sum))))
  (define result 0)
  (define (traverse node)
    (when (not (null? node))
      (let* ([res (helper node)]
             [sum (cadddr res)])
        (set! result (max result sum))
        (traverse (node-left node))
        (traverse (node-right node)))))
  (traverse root)
  (max 0 result))

(define-struct node (val left right) #:transparent)

(define (make-tree lst)
  (if (null? lst)
      '()
      (let ([val (car lst)])
        (if (null? val)
            '()
            (node val
                  (make-tree (cadr lst))
                  (make-tree (caddr lst)))))))