(define (collect-coins-in-tree n coins edges)
  ;; Build adjacency list
  (define adj (make-vector n '()))
  (for-each (lambda (edge)
              (let ((u (car edge))
                    (v (cadr edge)))
                (vector-set! adj u (cons v (vector-ref adj u)))
                (vector-set! adj v (cons u (vector-ref adj v)))))
            edges)

  ;; is-mandatory[i] will be true if node i is on a path from 0 to any coin
  (define is-mandatory (make-vector n #f))

  ;; DFS to mark mandatory nodes
  ;; Returns #t if current subtree (rooted at u) contains a coin, #f otherwise.
  ;; If it contains a coin, u is marked as mandatory.
  (define (dfs u parent)
    (let ((has-coin-in-subtree (= (vector-ref coins u) 1))) ; Check if u itself has a coin
      (for-each (lambda (v)
                  (when (not (= v parent))
                    (when (dfs v u)
                      (set! has-coin-in-subtree #t))))
                (vector-ref adj u))

      (when has-coin-in-subtree
        (vector-set! is-mandatory u #t))

      has-coin-in-subtree))

  ;; Start DFS from node 0 (the root)
  (dfs 0 -1)

  ;; Count edges where both endpoints are mandatory
  (define kept-edges 0)
  (for-each (lambda (edge)
              (let ((u (car edge))
                    (v (cadr edge)))
                (when (and (vector-ref is-mandatory u)
                           (vector-ref is-mandatory v))
                  (set! kept-edges (+ kept-edges 1)))))
            edges)

  kept-edges)