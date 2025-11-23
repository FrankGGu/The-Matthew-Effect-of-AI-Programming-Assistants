(define/contract (get-intersection-node headA headB)
  (-> (or/c list-node? #f) (or/c list-node? #f) (or/c list-node? #f))
  (let loop ([a headA] [b headB])
    (cond
      [(eq? a b) a]
      [(not a) (loop headB b)]
      [(not b) (loop a headA)]
      [else (loop (list-node-next a) (list-node-next b))])))