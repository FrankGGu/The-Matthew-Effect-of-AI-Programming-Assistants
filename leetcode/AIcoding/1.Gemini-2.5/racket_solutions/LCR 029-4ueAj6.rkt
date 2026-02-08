(require racket/contract)

(struct Node (val next) #:mutable)

(define/contract (insert head insertVal)
  (-> (or/c Node null?) integer? (or/c Node null?))
  (if (null? head)
      (let ([new-node (Node insertVal #f)])
        (set-Node-next! new-node new-node)
        new-node)
      (let ([curr-at-insertion-point
             (let loop ([curr head])
               (let ([next-node (Node-next curr)])
                 (cond
                   ;; Case 1: Normal insertion point
                   ;; curr.val <= insertVal <= next-node.val
                   [(and (<= (Node-val curr) insertVal)
                         (<= insertVal (Node-val next-node)))
                    curr]

                   ;; Case 2: Wrap-around point (curr.val > next-node.val)
                   ;; This means we've crossed the maximum to minimum boundary.
                   ;; Insert if insertVal is greater than the maximum (curr.val)
                   ;; or smaller than the minimum (next-node.val).
                   [(> (Node-val curr) (Node-val next-node))
                    (if (or (>= insertVal (Node-val curr))
                            (<= insertVal (Node-val next-node)))
                        curr
                        (loop next-node))]

                   ;; Case 3: We've traversed the entire list and haven't found a specific spot.
                   ;; This implies all elements are the same, or no clear sorted order for insertVal
                   ;; relative to distinct elements. In this case, insert anywhere (after curr).
                   ;; This condition is met when `next-node` is `head` again, completing a full cycle.
                   [(eq? next-node head)
                    curr]

                   ;; No insertion point found yet, continue to the next node
                   [else
                    (loop next-node)])))])
        (let ([new-node (Node insertVal (Node-next curr-at-insertion-point))])
          (set-Node-next! curr-at-insertion-point new-node))
        head)))