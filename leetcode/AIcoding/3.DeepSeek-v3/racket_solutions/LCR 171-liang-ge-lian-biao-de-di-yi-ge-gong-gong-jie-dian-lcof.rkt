(define/contract (get-intersection-node headA headB)
  (-> (or/c list-node? #f) (or/c list-node? #f) (or/c list-node? #f))
  (let loop ([pA headA] [pB headB] [switchA 0] [switchB 0])
    (cond
      [(not pA) (if (and (< switchA 2) pB) (loop headB pB (add1 switchA) switchB) #f)]
      [(not pB) (if (and (< switchB 2) pA) (loop pA headA switchA (add1 switchB)) #f)]
      [(eq? pA pB) pA]
      [else (loop (list-node-next pA) (list-node-next pB) switchA switchB)])))