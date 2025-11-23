#lang racket

(define (merge a b)
  (cond [(null? a) b]
        [(null? b) a]
        [(<= (car a) (car b))
         (cons (car a) (merge (cdr a) b))]
        [else
         (cons (car b) (merge a (cdr b)))]))

(define (inorder-traversal root)
  (if (null? root)
      '()
      (append (inorder-traversal (cadr root))
              (list (car root))
              (inorder-traversal (caddr root)))))

(define (get-elements root)
  (inorder-traversal root))

(define (get-all-elements root1 root2)
  (merge (get-elements root1) (get-elements root2)))