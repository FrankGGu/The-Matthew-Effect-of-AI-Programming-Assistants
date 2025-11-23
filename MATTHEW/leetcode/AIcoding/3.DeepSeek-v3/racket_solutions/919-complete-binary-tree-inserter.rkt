#lang racket

(define-struct cbt-node (val left right) #:mutable #:transparent)

(define (make-cbt-node [val 0] [left #f] [right #f])
  (cbt-node val left right))

(define cbt%
  (class object%
    (super-new)

    (init-field [root #f])

    (define q null)

    (define/public (insert val)
      (let ([new-node (make-cbt-node val)])
        (cond
          [(null? root) 
           (set! root new-node)
           (set! q (list root))]
          [else
           (let ([front (car q)])
             (cond
               [(not (cbt-node-left front))
                (set-cbt-node-left! front new-node)]
               [(not (cbt-node-right front))
                (set-cbt-node-right! front new-node)
                (set! q (cdr q))])
             (set! q (append q (list new-node)))])
        (cbt-node-val new-node)))

    (define/public (get_root)
      root)))