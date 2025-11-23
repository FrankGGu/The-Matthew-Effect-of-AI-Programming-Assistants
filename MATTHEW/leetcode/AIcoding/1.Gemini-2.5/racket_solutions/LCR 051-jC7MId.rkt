#lang racket

(struct TreeNode (val left right) #:transparent)

(define max-sum -inf.0) ; Initialize with negative infinity

(define (max-gain node)
  (if (not node) ; If node is #f (null)
      0
      (let* ((val (TreeNode-val node))
             ;; Recursively calculate the maximum gain from left and right children.
             ;; Only consider positive gains, otherwise, it's better to not include that branch.
             (left-gain (max 0 (max-gain (TreeNode-left node))))
             (right-gain (max 0 (max-gain (TreeNode-right node)))))

        ;; Update the global maximum path sum.
        ;; This path can include the current node and both its left and right branches.
        (set! max-sum (max max-sum (+ val left-gain right-gain)))

        ;; Return the maximum path sum that can be extended upwards from this node.
        ;; This path can only use one of its children's branches (the one with more gain).
        (+ val (max left-gain right-gain))))))

(define (max-path-sum root)
  ;; Reset max-sum for each test case.
  (set! max-sum -inf.0)
  ;; Start the recursive calculation from the root.
  (max-gain root)
  ;; After the traversal, max-sum will hold the overall maximum path sum.
  max-sum)