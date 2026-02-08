#lang racket

(struct TreeNode (val left right))

(define (find-target root k)
  ;; `seen` is a mutable hash table to store values encountered during traversal.
  (define seen (make-hash))

  ;; `found-flag` is a mutable boolean flag to indicate if a pair summing to `k` has been found.
  ;; This allows for early termination of the traversal.
  (define found-flag #f)

  ;; `dfs` performs a depth-first search on the tree.
  ;; It updates `found-flag` and `seen` as it traverses.
  (define (dfs node)
    (cond
      ;; Base case: If the current node is null, there's nothing to process.
      ;; Return the current state of `found-flag`.
      [(null? node) found-flag]

      [else
       ;; Get the value of the current node.
       (define current-val (TreeNode-val node))
       ;; Calculate the complement needed to sum to `k`.
       (define complement (- k current-val))

       ;; Check if the complement has already been seen.
       ;; If `found-flag` is already true, we don't need to check further for this node.
       ;; If `complement` is in `seen`, then we've found a pair.
       (when (and (not found-flag) (hash-has-key? seen complement))
         (set! found-flag #t)) ; Set the flag to true to indicate a pair is found.

       ;; Add the current node's value to the `seen` hash table.
       ;; This is done regardless of whether `found-flag` is true,
       ;; as `current-val` might be the complement for a future node.
       (hash-set! seen current-val #t) ; The value associated with the key doesn't matter, just its presence.

       ;; Recursively call `dfs` on the left and right children.
       ;; The `or` operator ensures short-circuiting:
       ;; - If `found-flag` is already true, it immediately returns true.
       ;; - Otherwise, it tries `dfs` on the left child. If that returns true, it short-circuits.
       ;; - Otherwise, it tries `dfs` on the right child.
       ;; This effectively propagates the `found-flag` up the call stack and stops further unnecessary traversal.
       (or found-flag
           (dfs (TreeNode-left node))
           (dfs (TreeNode-right node)))]))

  ;; Start the DFS traversal from the root.
  (dfs root)
  ;; Return the final state of `found-flag`.
  found-flag)