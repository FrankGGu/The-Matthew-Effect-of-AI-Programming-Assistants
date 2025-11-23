(define (get-max-time n headID manager informTime)
  ;; Build adjacency list: manager -> list of subordinates
  (define adj (make-vector n '())) ; Each element is a list of subordinates

  (for ([i (in-range n)])
    (let ([mgr (vector-ref manager i)])
      (unless (= mgr -1) ; -1 means no manager (headID)
        (vector-set! adj mgr (cons i (vector-ref adj mgr))))))

  ;; DFS function
  ;; Returns the maximum time needed to inform all employees in the subtree
  ;; rooted at current-employee-id, starting from current-employee-id itself.
  (define (dfs current-employee-id)
    (let ([subordinates (vector-ref adj current-employee-id)])
      (if (empty? subordinates)
          0 ; If no subordinates, this employee is a leaf in the hierarchy
            ; and doesn't add further time for informing its own reports.
          (+ (vector-ref informTime current-employee-id)
             (apply max (map dfs subordinates))))))

  ;; Start DFS from headID to find the total maximum time.
  (dfs headID))