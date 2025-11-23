(define/contract (delete-middle head)
  (-> (or/c list-node? #f) (or/c list-node? #f))
  (if (or (not head) (not (list-node-next head)))
      #f
      (let loop ([slow head]
                 [fast head]
                 [prev #f])
        (if (or (not fast) (not (list-node-next fast)))
            (begin
              (set-list-node-next! prev (list-node-next slow))
              head)
            (loop (list-node-next slow)
                  (list-node-next (list-node-next fast))
                  slow)))))