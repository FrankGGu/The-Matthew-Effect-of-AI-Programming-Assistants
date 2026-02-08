(define-struct node (val left right next))

(define (connect root)
  (define (helper nodes)
    (when (null? nodes) '())
    (define next-level
      (for/list ([n nodes])
        (cond
          [(node? n) (if (node? (node-left n)) (node-left n) '())
                         (if (node? (node-right n)) (node-right n) '()))]))
    (for ([i (in-range (sub1 (length nodes)))])
      (set! (node-next (list-ref nodes i)) (list-ref nodes (add1 i))))
    (append (filter node? nodes) (helper (filter node? next-level))))
  (helper (list root)))