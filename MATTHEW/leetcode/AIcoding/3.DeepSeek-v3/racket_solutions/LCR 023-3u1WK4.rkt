(define/contract (get-intersection-node headA headB)
  (-> (or/c list-node? #f) (or/c list-node? #f) (or/c list-node? #f))
  (let loop ([pA headA] [pB headB] [switchA #f] [switchB #f])
    (cond
      [(eq? pA pB) pA]
      [(not pA) (if switchA #f (loop headB pB #t switchB))]
      [(not pB) (if switchB #f (loop pA headA switchA #t))]
      [else (loop (list-node-next pA) (list-node-next pB) switchA switchB)])))