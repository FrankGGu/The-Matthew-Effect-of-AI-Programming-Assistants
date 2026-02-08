(struct TreeNode (val left right))

(define ans 0)

(define (min-camera-cover root)
  (set! ans 0)

  ;; States for a node:
  ;; 0: The node is not monitored and does not have a camera. (Needs parent or self to monitor)
  ;; 1: The node is monitored and does not have a camera. (Covered by child or parent)
  ;; 2: The node has a camera. (Covers self, parent, children)

  (define (dfs node)
    (cond
      [(null? node) 1] ; A null node is considered monitored and doesn't need a camera.

      [else
       (define left-state (dfs (TreeNode-left node)))
       (define right-state (dfs (TreeNode-right node)))

       (cond
         ;; Case 1: One of the children is not monitored (state 0).
         ;; To monitor the unmonitored child, we MUST place a camera at the current node.
         [(or (= left-state 0) (= right-state 0))
          (set! ans (+ ans 1))
          2] ; Current node has a camera.

         ;; Case 2: One of the children has a camera (state 2).
         ;; The current node is monitored by its child. It doesn't need a camera itself.
         [(or (= left-state 2) (= right-state 2))
          1] ; Current node is monitored, no camera.

         ;; Case 3: Both children are monitored (state 1) but don't have cameras.
         ;; The current node is NOT monitored by its children. It also doesn't have a camera.
         ;; It needs its parent to monitor it.
         [else
          0] ; Current node is not monitored, no camera.
         )]))

  (define root-state (dfs root))

  ;; If the root itself is not monitored after the DFS (state 0),
  ;; it means it needs a camera.
  (when (= root-state 0)
    (set! ans (+ ans 1)))

  ans)