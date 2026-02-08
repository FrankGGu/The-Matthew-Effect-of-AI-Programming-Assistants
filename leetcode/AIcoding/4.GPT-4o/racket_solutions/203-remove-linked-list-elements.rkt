(define (remove-elements head val)
  (define (helper node)
    (cond
      [(null? node) '()]
      [(= (node-value node) val) (helper (node-next node))]
      [else (cons (node-value node) (helper (node-next node)))]))
  (let ((filtered (helper head)))
    (if (null? filtered)
        (make-node 0 '())  ; Return a new empty node if all elements are removed
        (fold-right (lambda (x acc) (make-node x acc)) '() filtered))))