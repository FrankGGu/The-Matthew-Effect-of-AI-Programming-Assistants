#lang racket

(define (level-order root)
  (if (not root)
      '()
      (let loop ([nodes (list root)] [result '()])
        (if (null? nodes)
            (reverse result)
            (let* ([next-nodes '()]
                   [current-values '()])
              (for-each
               (lambda (node)
                 (set! current-values (append current-values (list (node-value node))))
                 (set! next-nodes (append next-nodes (node-children node))))
               nodes)
              (loop next-nodes (cons current-values result)))))))