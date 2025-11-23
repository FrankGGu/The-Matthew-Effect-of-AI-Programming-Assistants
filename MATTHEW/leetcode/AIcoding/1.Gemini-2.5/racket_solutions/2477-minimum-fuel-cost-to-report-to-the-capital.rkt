(define (minimum-fuel-cost n roads seats)
  (define graph (make-vector n '()))

  (for ([road roads])
    (define u (car road))
    (define v (cadr road))
    (vector-set! graph u (cons v (vector-ref graph u)))
    (vector-set! graph v (cons u (vector-ref graph v))))

  (let ([total-fuel-cost 0])
    (define (dfs node parent)
      (define people-count 1) ; One person at the current node

      (for ([child (vector-ref graph node)])
        (when (not (= child parent))
          (define child-people (dfs child node))
          (set! people-count (+ people-count child-people))

          ; Calculate cars needed to move people from child's subtree to current node
          (define cars-needed (exact-ceiling child-people seats))
          (set! total-fuel-cost (+ total-fuel-cost cars-needed))))

      people-count) ; Return the total people in this node's subtree

    (dfs 0 -1) ; Start DFS from the capital (node 0) with a dummy parent -1
    total-fuel-cost))