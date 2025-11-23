#lang racket

(struct TreeNode (val left right))

(define (build-tree preorder-list inorder-list)
  (define n (length preorder-list))

  (when (zero? n)
    #f)

  (define preorder (list->vector preorder-list))
  (define inorder (list->vector inorder-list))

  (define inorder-map (make-hash))
  (for ([val (in-vector inorder)]
        [idx (in-naturals)])
    (hash-set! inorder-map val idx))

  (define (build-tree-helper pre-start pre-end in-start in-end)
    (if (or (>= pre-start pre-end) (>= in-start in-end))
        #f
        (let* ([root-val (vector-ref preorder pre-start)]
               [root-idx-in-inorder (hash-ref inorder-map root-val)]
               [left-subtree-size (- root-idx-in-inorder in-start)]
               [left-child (build-tree-helper
                            (+ pre-start 1)
                            (+ pre-start 1 left-subtree-size)
                            in-start
                            root-idx-in-inorder)]
               [right-child (build-tree-helper
                             (+ pre-start 1 left-subtree-size)
                             pre-end
                             (+ root-idx-in-inorder 1)
                             in-end)])
          (TreeNode root-val left-child right-child))))

  (build-tree-helper 0 n 0 n))