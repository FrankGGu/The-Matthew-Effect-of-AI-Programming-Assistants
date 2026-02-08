#lang racket

(define (closestNodes root queries)
  (define (in-order-traversal node)
    (if (null? node)
        '()
        (append (in-order-traversal (node-left node))
                (list (node-val node))
                (in-order-traversal (node-right node)))))

  (define sorted-nodes (in-order-traversal root))

  (define (find-closest x)
    (define (binary-search lst target)
      (let loop ((left 0) (right (sub1 (length lst))))
        (if (> left right)
            (list '() '())
            (define mid (quotient (+ left right) 2))
            (cond
              [(= (list-ref lst mid) target)
               (list (list-ref lst mid) (list-ref lst mid))]
              [(< (list-ref lst mid) target)
               (loop (add1 mid) right)]
              [else
               (loop left (sub1 mid))]))))

    (define closest (binary-search sorted-nodes x))
    (define lower (car closest))
    (define upper (cadr closest))
    (list (if (null? lower) -1 lower)
          (if (null? upper) -1 upper)))

  (map find-closest queries))

(define (node-left node)
  (if (null? node) '() (node-left node)))

(define (node-right node)
  (if (null? node) '() (node-right node)))

(define (node-val node)
  (if (null? node) '() (node-val node)))

(define (create-node val left right)
  (list 'node val left right))