(define (maximum-score-after-applying-operations-on-a-tree n edges coins)
  (define adj (make-vector n (list)))
  (for-each (lambda (edge)
              (let ((u (car edge))
                    (v (cadr edge)))
                (vector-set! adj u (cons v (vector-ref adj u)))
                (vector-set! adj v (cons u (vector-ref adj v)))))
            edges)

  (define memo (make-hash)) ; Stores (u . p) -> (dp0, dp1, dp2)

  (define (dfs u p)
    (define memo-key (cons u p))
    (hash-ref memo memo-key
              (lambda ()
                (let* ((children (filter (lambda (v) (not (= v p))) (vector-ref adj u)))
                       (dp0-val 0) ; u not selected, p not selected
                       (dp1-val 0) ; u selected
                       (dp2-val 0)) ; u not selected, p selected

                  ;; Base case: Leaf node
                  (when (null? children)
                    (set! dp0-val 0)
                    (set! dp1-val (list-ref coins u))
                    (set! dp2-val (list-ref coins u)))

                  (unless (null? children)
                    (let ((sum-dp2-children 0)
                          (sum-max-dp0-dp1-children 0)
                          (score-if-no-child-selected 0)
                          (score-if-at-least-one-child-selected (list-ref coins u))
                          (max-gain-from-child-selection 0))

                      (for-each (lambda (v)
                                  (let* ((res-v (dfs v u))
                                         (v0 (car res-v))
                                         (v1 (cadr res-v))
                                         (v2 (caddr res-v)))

                                    ;; For dp1 (u selected): children must be in state 2
                                    (set! sum-dp2-children (+ sum-dp2-children v2))

                                    ;; For dp2 (u not selected, p selected): children can be in state 0 or 1
                                    (set! sum-max-dp0-dp1-children (+ sum-max-dp0-dp1-children (max v0 v1)))

                                    ;; For dp0 (u not selected, p not selected):
                                    ;; Part 1: sum if no child is selected (u gets 0)
                                    (set! score-if-no-child-selected (+ score-if-no-child-selected v0))
                                    ;; Part 2: sum if at least one child is selected (u gets coins[u])
                                    (set! score-if-at-least-one-child-selected (+ score-if-at-least-one-child-selected v0))
                                    (set! max-gain-from-child-selection (max max-gain-from-child-selection (- v1 v0)))
                                    ))
                                children)

                      ;; Calculate dp1
                      (set! dp1-val (+ (list-ref coins u) sum-dp2-children))

                      ;; Calculate dp2
                      (set! dp2-val (+ (list-ref coins u) sum-max-dp0-dp1-children))

                      ;; Calculate dp0
                      (set! score-if-at-least-one-child-selected
                            (+ score-if-at-least-one-child-selected max-gain-from-child-selection))
                      (set! dp0-val (max score-if-no-child-selected score-if-at-least-one-child-selected))
                      ))

                  (hash-set! memo memo-key (list dp0-val dp1-val dp2-val))
                  (list dp0-val dp1-val dp2-val))))

  (let ((result (dfs 0 -1))) ; Start DFS from root 0, with dummy parent -1
    (max (car result) (cadr result)))) ; Final answer is max of dp[0][0] and dp[0][1]