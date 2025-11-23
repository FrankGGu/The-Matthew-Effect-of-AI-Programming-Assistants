#lang racket

(struct TreeNode (val left right) #:transparent)

(define (inorder-successor root p)
  (let loop ((current root) (successor #f))
    (cond
      ((not current) successor) ; If current node is #f, we've gone too far, return the best successor found so far.
      ((= (TreeNode-val p) (TreeNode-val current))
       ; Found node p.
       ; If p has a right child, the successor is the leftmost node in its right subtree.
       (if (TreeNode-right current)
           (let loop-left ((node (TreeNode-right current)))
             (if (TreeNode-left node)
                 (loop-left (TreeNode-left node))
                 node))
           ; If p has no right child, the successor is the ancestor found so far (passed as 'successor' argument).
           successor))
      ((< (TreeNode-val p) (TreeNode-val current))
       ; p is in the left subtree of current.
       ; current could be p's successor, so store it and search in the left subtree.
       (loop (TreeNode-left current) current))
      (else ; (> (TreeNode-val p) (TreeNode-val current))
       ; p is in the right subtree of current.
       ; current cannot be p's successor (it's smaller or p itself). Search in the right subtree.
       (loop (TreeNode-right current) successor)))))