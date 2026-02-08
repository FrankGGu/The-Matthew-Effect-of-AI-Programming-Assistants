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
  (define (split head)
    (cond [(or (not head) (not (list-node-next head))) head]
          [else
           (let ([slow head]
                 [fast (list-node-next head)])
             (while (and fast (list-node-next fast))
               (set! slow (list-node-next slow))
               (set! fast (list-node-next (list-node-next fast))))
             (let ([mid (list-node-next slow)])
               (set-list-node-next! slow #f)
               mid))]))
  (cond [(or (not head) (not (list-node-next head))) head]
        [else
         (let ([mid (split head)])
           (merge (sort-list head) (sort-list mid)))]))