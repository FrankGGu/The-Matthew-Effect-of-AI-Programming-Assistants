(define/contract (has-cycle head)
  (-> (or/c list-node? #f) boolean?)
  (let loop ([slow head] [fast head])
    (cond
      [(or (not fast) (not (list-node-next fast))) #f]
      [(eq? slow (list-node-next fast)) #t]
      [else (loop (list-node-next slow) (list-node-next (list-node-next fast)))])))