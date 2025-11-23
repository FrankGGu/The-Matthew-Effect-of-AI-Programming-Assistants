#lang racket

(struct TreeNode (val left right) #:transparent)

(define (find-bottom-left-value root)
  (define max-depth (box -1)) ; Stores the maximum depth found so far
  (define bottom-left-val (box 0)) ; Stores the value of the bottom-left node

  (define (dfs node current-depth)
    (when node
      ; If current-depth is strictly greater than max-depth, it means we've reached a new deepest level.
      ; Due to the left-first traversal (left child before right child),
      ; the first node encountered at this new deepest level will be the leftmost node for that level.
      ; Therefore, this node's value is the current candidate for the bottom-left value.
      (when (> current-depth (unbox max-depth))
        (set-box! max-depth current-depth)
        (set-box! bottom-left-val (TreeNode-val node)))

      ; Recursively traverse the left child first to ensure we prioritize leftmost nodes
      (dfs (TreeNode-left node) (+ current-depth 1))
      ; Then traverse the right child
      (dfs (TreeNode-right node) (+ current-depth 1))))

  ; Start the Depth-First Search from the root node at depth 0
  (dfs root 0)

  ; Return the value stored in bottom-left-val, which will be the bottom-left tree value
  (unbox bottom-left-val))