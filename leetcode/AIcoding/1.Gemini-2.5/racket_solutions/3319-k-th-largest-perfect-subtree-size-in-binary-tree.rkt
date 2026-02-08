(define (kth-largest-perfect-subtree-size root k)
  ;; Helper function to traverse the tree.
  ;; It returns three values:
  ;; 1. is-perfect?: A boolean indicating if the subtree rooted at 'node' is perfect.
  ;; 2. height: The height of the subtree if it's perfect, otherwise -1.
  ;; 3. perfect-subtree-sizes: A list of sizes of all perfect subtrees found within this subtree (including itself if perfect).
  (define (dfs node)
    (if (null? node)
        ;; An empty tree is considered perfect with height -1.
        ;; It does not contribute any positive size to the list of perfect subtrees.
        (values #t -1 '())
        (let-values (((left-is-perfect? left-height left-sizes) (dfs (TreeNode-left node)))
                     ((right-is-perfect? right-height right-sizes) (dfs (TreeNode-right node))))
          (let* ((current-node-is-perfect? (and left-is-perfect?
                                                right-is-perfect?
                                                (= left-height right-height)))
                 (current-node-height (if current-node-is-perfect?
                                          (+ left-height 1)
                                          -1)) ; If not perfect, its height is irrelevant for parent's perfectness check.
                 (current-node-size (if current-node-is-perfect?
                                        (- (expt 2 (+ current-node-height 1)) 1)
                                        0))) ; Calculate size if current node forms a perfect subtree.
            ;; Combine sizes from left, right, and current node (if perfect).
            (let ((all-collected-sizes (append left-sizes right-sizes
                                               (if current-node-is-perfect? (list current-node-size) '()))))
              (values current-node-is-perfect? current-node-height all-collected-sizes))))))

  ;; Start DFS from the root. We only care about the list of all perfect subtree sizes.
  (let-values (((_ _ all-perfect-sizes) (dfs root)))
    ;; Sort the collected sizes in descending order.
    (let ((sorted-sizes (sort all-perfect-sizes >)))
      ;; Return the K-th largest size.
      ;; The problem usually guarantees that k is a valid index (1-indexed).
      (list-ref sorted-sizes (- k 1)))))