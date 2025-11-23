#lang racket

(define-struct: TreeNode ([val : any] [left : (U TreeNode #f)] [right : (U TreeNode #f)]))

(define (largest-values root)
  (define (bfs queue result)
    (cond [(null? queue) result]
          [else
           (define current-level (map (lambda (node) (TreeNode-val node)) queue))
           (define max-val (apply max current-level))
           (define next-level
             (append*
              (map (lambda (node)
                     (filter (lambda (x) x)
                             (list (TreeNode-left node) (TreeNode-right node))))
                   queue)))
           (bfs next-level (append result (list max-val)))]))
  (if (not root)
      '()
      (bfs (list root) '())))