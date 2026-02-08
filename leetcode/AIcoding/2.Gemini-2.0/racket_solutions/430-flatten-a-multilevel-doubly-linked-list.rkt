(define (flatten head)
  (define (flatten-helper node)
    (cond
      [(null? node) (values null null)]
      [else
       (let* ([next-node (->next node)]
              [child-node (->child node)])
         (cond
           [(null? child-node)
            (let-values ([(tail next-tail) (flatten-helper next-node)])
              (set! (->next node) next-node)
              (if (not (null? next-node)) (set! (->prev next-node) node))
              (values node (or next-tail node)))]
           [else
            (set! (->child node) null)
            (let-values ([(child-tail child-next-tail) (flatten-helper child-node)])
              (set! (->next node) child-node)
              (set! (->prev child-node) node)
              (let-values ([(tail next-tail) (flatten-helper next-node)])
                (if (not (null? child-tail))
                    (begin
                      (set! (->next child-tail) next-node)
                      (if (not (null? next-node)) (set! (->prev next-node) child-tail)))
                    (if (not (null? next-node)) (set! (->prev next-node) node)))
                (values node (or next-tail child-tail node)))))]))]))
  (if (null? head) head
      (begin
        (flatten-helper head)
        head)))