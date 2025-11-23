(define (find-number-of-coins-to-place-in-tree-nodes n edges costs)
  (define adj (make-vector n '()))
  (for-each (lambda (edge)
              (let ((u (list-ref edge 0))
                    (v (list-ref edge 1)))
                (vector-set! adj u (cons v (vector-ref adj u)))
                (vector-set! adj v (cons u (vector-ref adj v)))))
            edges)

  (define ans (make-vector n 0))

  ; dfs returns (subtree-node-count, list-of-up-to-5-relevant-costs)
  ; The list-of-up-to-5-relevant-costs will be sorted (smallest to largest).
  (define (dfs u parent)
    (let* ((current-node-cost (vector-ref costs u))
           (current-subtree-costs (list current-node-cost))
           (current-subtree-node-count 1))

      (for-each (lambda (v)
                  (when (not (= v parent))
                    (let-values (((child-node-count child-costs) (dfs v u)))
                      (set! current-subtree-node-count (+ current-subtree-node-count child-node-count))
                      (set! current-subtree-costs (append current-subtree-costs child-costs))
                      ; Keep current-subtree-costs to at most 5 elements (2 smallest, 3 largest)
                      (set! current-subtree-costs (sort current-subtree-costs <))
                      (when (> (length current-subtree-costs) 5)
                        (set! current-subtree-costs
                              (list (list-ref current-subtree-costs 0)
                                    (list-ref current-subtree-costs 1)
                                    (list-ref current-subtree-costs (- (length current-subtree-costs) 3))
                                    (list-ref current-subtree-costs (- (length current-subtree-costs) 2))
                                    (list-ref current-subtree-costs (- (length current-subtree-costs) 1))))))))
                (vector-ref adj u))

      ; Calculate answer for node u
      (if (< current-subtree-node-count 3)
          (vector-set! ans u 1) ; Problem statement: if < 3 nodes, place 1 coin.
          (let* ((len (length current-subtree-costs))
                 (max-prod 0))
            ; Since current-subtree-node-count >= 3, 'len' (length of current-subtree-costs)
            ; is guaranteed to be >= 3. So, list-ref indices are safe.

            ; Case 1: Product of 3 largest numbers
            (let ((prod1 (* (list-ref current-subtree-costs (- len 1))
                            (list-ref current-subtree-costs (- len 2))
                            (list-ref current-subtree-costs (- len 3)))))
              (set! max-prod (max max-prod prod1)))

            ; Case 2: Product of 2 smallest (potentially negative) and 1 largest number
            (let ((prod2 (* (list-ref current-subtree-costs 0)
                            (list-ref current-subtree-costs 1)
                            (list-ref current-subtree-costs (- len 1)))))
              (set! max-prod (max max-prod prod2)))

            (vector-set! ans u max-prod)))

      (values current-subtree-node-count current-subtree-costs)))

  (dfs 0 -1) ; Start DFS from node 0, with -1 as its parent (indicating no parent)

  (vector->list ans))