(define/contract (sort-list head)
  (-> (or/c list-node? #f) (or/c list-node? #f))
  (define (merge l1 l2)
    (cond [(not l1) l2]
          [(not l2) l1]
          [(<= (list-node-val l1) (list-node-val l2))
           (set-list-node-next! l1 (merge (list-node-next l1) l2))
           l1]
          [else
           (set-list-node-next! l2 (merge l1 (list-node-next l2)))
           l2]))
  (define (get-mid head)
    (let loop ([slow head] [fast head] [prev #f])
      (if (or (not fast) (not (list-node-next fast)))
          (values slow prev)
          (loop (list-node-next slow) (list-node-next (list-node-next fast)) slow))))
  (define (merge-sort head)
    (if (or (not head) (not (list-node-next head)))
        head
        (let-values ([(mid prev) (get-mid head)])
          (when prev (set-list-node-next! prev #f))
          (merge (merge-sort head) (merge-sort mid)))))
  (merge-sort head))