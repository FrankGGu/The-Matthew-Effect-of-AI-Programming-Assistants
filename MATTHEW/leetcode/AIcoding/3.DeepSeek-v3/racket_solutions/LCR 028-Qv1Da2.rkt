(define (flatten head)
  (define (helper node)
    (cond
      [(null? node) (cons null null)]
      [else
       (let* ([next-node (node-next node)]
              [child-node (node-child node)]
              [tail (helper node)])
         (when (not (null? child-node))
           (let* ([child-result (helper child-node)]
                  [child-head (car child-result)]
                  [child-tail (cdr child-result)])
             (set-node-next! node child-head)
             (set-node-prev! child-head node)
             (set-node-child! node null)
             (set-node-next! child-tail next-node)
             (when (not (null? next-node))
               (set-node-prev! next-node child-tail))
             (set! tail (helper child-tail))))
         (if (null? next-node)
             (cons node tail)
             (cons node (cdr (helper next-node)))))]))
  (car (helper head)))