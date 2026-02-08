#lang racket

(struct Node (val prev next child))

(define (flatten head)
  (define (dfs node)
    (if (null? node)
        '()
        (let* ([next (Node-next node)]
               [child (Node-child node)]
               [flat-child (dfs child)]
               [flat-next (dfs next)])
          (if (null? flat-child)
              (cons node flat-next)
              (begin
                (set! (Node-next node) (car flat-child))
                (set! (Node-prev (car flat-child)) node)
                (append (list node) flat-child flat-next))))))
  (car (dfs head)))