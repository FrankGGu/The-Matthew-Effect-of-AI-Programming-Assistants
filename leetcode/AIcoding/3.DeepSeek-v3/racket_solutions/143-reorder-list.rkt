(define/contract (reorder-list head)
  (-> (or/c list-node? #f) void?)
  (when head
    (let* ([slow head]
           [fast head])
      (let loop ()
        (when (and (list-node-next fast) (list-node-next (list-node-next fast)))
          (set! slow (list-node-next slow))
          (set! fast (list-node-next (list-node-next fast)))
          (loop)))
      (let* ([prev #f]
             [curr (list-node-next slow)])
        (set-list-node-next! slow #f)
        (let loop ()
          (when curr
            (let ([next (list-node-next curr)])
              (set-list-node-next! curr prev)
              (set! prev curr)
              (set! curr next)
              (loop)))))
        (let* ([first head]
               [second prev])
          (let loop ()
            (when second
              (let ([tmp1 (list-node-next first)]
                    [tmp2 (list-node-next second)])
                (set-list-node-next! first second)
                (set-list-node-next! second tmp1)
                (set! first tmp1)
                (set! second tmp2)
                (loop))))))))