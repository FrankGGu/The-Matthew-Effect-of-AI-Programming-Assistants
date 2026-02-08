(define (remove-nodes head)
  (cond
    [(null? head) head]
    [else
     (let* ([next-node (remove-nodes (cdr head))]
            [max-val (if (null? next-node)
                         (car head)
                         (max (car head) (car next-node)))])
       (if (> (car head) max-val)
           head
           next-node))]))