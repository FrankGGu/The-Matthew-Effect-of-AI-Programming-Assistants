(define (maximum-points-after-collecting-coins-from-all-nodes edges coins k)
  (define n (vector-length coins))
  (define adj (make-vector n '()))

  ;; Build adjacency list for the tree
  (for-each (lambda (edge)
              (let ((u (vector-ref edge 0))
                    (v (vector-ref edge 1)))
                (vector-set! adj u (cons v (vector-ref adj u)))
                (vector-set! adj v (cons u (vector-ref adj v)))))
            edges)

  ;; Determine the maximum relevant power of 2 for division.
  ;; coins[i] are up to 10^4.
  ;; 2^13 = 8192, 2^14 = 16384.
  ;; If coins[i] is divided by 2^14 or more, it becomes 0.
  ;; So, we only need to track p-count up to 14.
  ;; The actual limit is min(k, 14) as k can be smaller or larger.
  (define MAX_POWER (min k 14))

  ;; Memoization table: memo[node_idx][power_count]
  ;; Stores the maximum points for the subtree rooted at node_idx,
  ;; given that its coins have been effectively divided by 2^power_count.
  ;; power_count ranges from 0 to MAX_POWER, so (add1 MAX_POWER) size.
  (define memo (make-vector n (make-vector (add1 MAX_POWER) #f)))

  ;; A sufficiently small number to represent negative infinity for comparison.
  ;; This ensures that invalid options are not chosen.
  (define -inf.0 -1000000000000000000)

  ;; Depth-First Search (DFS) function for dynamic programming
  ;; u: current node being processed
  ;; parent: parent of u (to prevent traversing back up the tree)
  ;; p-count: the cumulative number of times the original coin value
  ;;          has been divided by 2 along the path from the root to u,
  ;;          before u makes its own decision.
  (define (dfs u parent p-count)
    ;; Check if this state has already been computed
    (let ((memo-val (vector-ref (vector-ref memo u) p-count)))
      (if memo-val
          memo-val ; Return memoized value
          ;; If not computed, calculate it
          (let* ((current-node-initial-coins (vector-ref coins u))
                 ;; Calculate the effective coins at node u based on p-count
                 (effective-coins-at-u (floor (/ current-node-initial-coins (expt 2 p-count)))))

            ;; Option 1: Collect all effective coins at node u
            (let ((points-option1 (+ effective-coins-at-u
                                     ;; Sum points from children, passing the same p-count
                                     (apply + (map (lambda (v)
                                                     (if (= v parent)
                                                         0 ; Don't recurse to parent
                                                         (dfs v u p-count)))
                                                   (vector-ref adj u))))))

              ;; Option 2: Collect half of the effective coins at node u
              (let ((points-option2 (if (<= (add1 p-count) MAX_POWER)
                                        ;; This option is only valid if we haven't exceeded
                                        ;; the total allowed divisions (MAX_POWER)
                                        (+ (floor (/ effective-coins-at-u 2))
                                           ;; Sum points from children, passing an incremented p-count
                                           (apply + (map (lambda (v)
                                                           (if (= v parent)
                                                               0 ; Don't recurse to parent
                                                               (dfs v u (add1 p-count))))
                                                         (vector-ref adj u))))
                                        -inf.0))) ; If not allowed, this option yields -inf.0

                ;; The result for the current state is the maximum of the two options
                (let ((max-res (max points-option1 points-option2)))
                  ;; Store the computed result in the memoization table
                  (vector-set! (vector-ref memo u) p-count max-res)
                  max-res)))))))

  ;; Start the DFS from the root node (node 0), with a dummy parent -1,
  ;; and an initial p-count of 0 (no divisions from ancestors yet).
  (dfs 0 -1 0))