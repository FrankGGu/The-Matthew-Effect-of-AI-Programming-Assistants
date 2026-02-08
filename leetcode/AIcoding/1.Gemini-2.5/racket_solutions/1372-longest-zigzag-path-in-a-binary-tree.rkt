(struct TreeNode (val left right) #:transparent)

(define (longest-zigzag-path root)
  (define max-len (box 0))

  ; dfs returns (values longest-path-starting-left longest-path-starting-right)
  ; longest-path-starting-left: longest zigzag path starting at 'node' and taking a left turn first.
  ; longest-path-starting-right: longest zigzag path starting at 'node' and taking a right turn first.
  ; The length is the number of edges.
  (define (dfs node)
    (when (not node)
      (values 0 0)) ; Base case: A null node contributes 0 to zigzag path length.

    ; Recursively get lengths from children
    (define-values left-len-from-left-child right-len-from-left-child
      (dfs (TreeNode-left node)))

    (define-values left-len-from-right-child right-len-from-right-child
      (dfs (TreeNode-right node)))

    ; Calculate the longest zigzag path starting at 'node' and going left.
    ; This path takes an edge 'node' -> 'node.left' (length 1).
    ; From 'node.left', the path must then go right to maintain zigzag.
    (define current-left-path-len
      (if (TreeNode-left node)
          (+ 1 right-len-from-left-child)
          0)) ; If no left child, no path can start by going left.

    ; Calculate the longest zigzag path starting at 'node' and going right.
    ; This path takes an edge 'node' -> 'node.right' (length 1).
    ; From 'node.right', the path must then go left to maintain zigzag.
    (define current-right-path-len
      (if (TreeNode-right node)
          (+ 1 left-len-from-right-child)
          0)) ; If no right child, no path can start by going right.

    ; Update the global maximum length found so far.
    ; A zigzag path can start at any node. The 'current-left-path-len' and
    ; 'current-right-path-len' represent the longest paths starting at the
    ; current 'node'.
    (set-box! max-len (max (unbox max-len) current-left-path-len current-right-path-len))

    ; Return the calculated lengths for the current node to be used by its parent.
    (values current-left-path-len current-right-path-len))

  ; Initiate the DFS traversal from the root.
  ; The return value of this initial call is not directly used for the final answer,
  ; as the 'max-len' box captures the overall maximum through side effects.
  (dfs root) 

  ; Return the final maximum zigzag path length found.
  (unbox max-len))