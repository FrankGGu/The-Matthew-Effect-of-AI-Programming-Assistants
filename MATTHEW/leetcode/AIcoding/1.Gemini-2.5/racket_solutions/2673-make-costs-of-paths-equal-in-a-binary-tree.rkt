#lang racket

(define (min-cost-equal-paths cost)
  (let* ([n (vector-length cost)]
         [total-increase (make-box 0)])

    ;; dfs returns the maximum path sum from node i to a leaf in its subtree,
    ;; after all necessary adjustments have been made within that subtree
    ;; to make its root-to-leaf paths equal.
    ;; This returned value *includes* cost[i].
    (define (dfs i)
      (if (>= i n)
          ;; Non-existent node. Its path sum contribution is 0.
          0
          (let* ([left-child-idx (+ (* 2 i) 1)]
                 [right-child-idx (+ (* 2 i) 2)]

                 ;; Recursively get the maximum path sums from children downwards.
                 ;; These values already include the child's cost and are adjusted
                 ;; to make paths equal within their own subtrees.
                 [left-path-sum-from-child (dfs left-child-idx)]
                 [right-path-sum-from-child (dfs right-child-idx)])

            (let* ([current-node-cost (vector-ref cost i)]
                   [max-path-from-children 0]
                   [diff-to-add 0])

              (if (>= left-child-idx n)
                  ;; Node i is a leaf (it has no children).
                  ;; No paths to equalize from this node.
                  (begin
                    (set! max-path-from-children 0)
                    (set! diff-to-add 0))
                  (if (>= right-child-idx n)
                      ;; Node i has only a left child (right child does not exist).
                      ;; No right path to equalize with.
                      (begin
                        (set! max-path-from-children left-path-sum-from-child)
                        (set! diff-to-add 0))
                      ;; Node i has both left and right children.
                      ;; We need to make the paths through these children equal.
                      (begin
                        (set! max-path-from-children (max left-path-sum-from-child right-path-sum-from-child))
                        (set! diff-to-add (abs (- left-path-sum-from-child right-path-sum-from-child))))))

              ;; Add the cost needed to equalize children paths at this level to the total.
              (set-box! total-increase (+ (unbox total-increase) diff-to-add))

              ;; Return the maximum path sum from node i to a leaf in its subtree,
              ;; after adjustments. This path sum includes current-node-cost.
              (+ current-node-cost max-path-from-children))))))

    ;; Start DFS from the root (node 0).
    ;; The return value of dfs 0 is the final max path sum, which is not needed for the answer.
    ;; The total accumulated increase is in `total-increase`.
    (dfs 0)
    (unbox total-increase)))