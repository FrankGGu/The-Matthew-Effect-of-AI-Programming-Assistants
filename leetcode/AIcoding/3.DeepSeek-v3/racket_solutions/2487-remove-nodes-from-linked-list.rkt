(define/contract (remove-nodes head)
  (-> (or/c list-node? #f) (or/c list-node? #f))
  (define (reverse-list node)
    (let loop ([prev #f] [curr node])
      (if (not curr)
          prev
          (let ([next (list-node-next curr)])
            (set-list-node-next! curr prev)
            (loop curr next)))))
  (define (remove-smaller-nodes node)
    (let loop ([prev #f] [curr node] [max-val -inf.0])
      (if (not curr)
          #f
          (let ([val (list-node-val curr)]
                [next (list-node-next curr)])
            (if (< val max-val)
                (loop prev next max-val)
                (begin
                  (when prev
                    (set-list-node-next! prev curr))
                  (loop curr next val)))))))
  (let* ([reversed (reverse-list head)]
         [processed (remove-smaller-nodes reversed)])
    (reverse-list processed)))