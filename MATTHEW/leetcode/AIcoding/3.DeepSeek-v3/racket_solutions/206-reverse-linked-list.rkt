(define/contract (reverse-list head)
  (-> (or/c list-node? #f) (or/c list-node? #f))
  (let loop ([prev #f] [curr head])
    (if (not curr)
        prev
        (let ([next (list-node-next curr)])
          (set-list-node-next! curr prev)
          (loop curr next)))))