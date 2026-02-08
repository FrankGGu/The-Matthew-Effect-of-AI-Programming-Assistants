(define/contract (flatten head)
  (-> (or/c dlink-node? #f) (or/c dlink-node? #f))
  (define (helper node)
    (cond
      [(not node) (cons #f #f)]
      [else
       (let* ([next-node (dlink-node-next node)]
              [child-node (dlink-node-child node)]
              [tail-node (helper child-node)]
              [child-head (car tail-node)]
              [child-tail (cdr tail-node)]
              [tail-node-next (helper next-node)]
              [next-head (car tail-node-next)]
              [next-tail (cdr tail-node-next)])
         (begin
           (set-dlink-node-child! node #f)
           (cond
             [(and child-head child-tail)
              (set-dlink-node-next! node child-head)
              (set-dlink-node-prev! child-head node)
              (set-dlink-node-next! child-tail next-head)
              (when next-head
                (set-dlink-node-prev! next-head child-tail))
              (cons node (if next-tail next-tail child-tail))]
             [else
              (set-dlink-node-next! node next-head)
              (when next-head
                (set-dlink-node-prev! next-head node))
              (cons node (if next-tail next-tail node))])))]))
  (car (helper head)))