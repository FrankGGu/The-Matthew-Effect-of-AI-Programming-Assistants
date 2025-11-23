#lang racket

(struct TreeNode (val left right) #:transparent)

(define height-map (make-hash))
(define ans-map (make-hash))

(define (dfs1 node)
  (if (null? node)
      -1
      (let* ((left-h (dfs1 (TreeNode-left node)))
             (right-h (dfs1 (TreeNode-right node)))
             (current-h (+ 1 (max left-h right-h))))
        (hash-set! height-map (TreeNode-val node) current-h)
        current-h)))

(define (dfs2 node max-height-from-above)
  (when (not (null? node))
    (hash-set! ans-map (TreeNode-val node) max-height-from-above)

    (let* ((left-node (TreeNode-left node))
           (right-node (TreeNode-right node))
           (left-subtree-height (if (null? left-node) -1 (hash-ref height-map (TreeNode-val left-node))))
           (right-subtree-height (if (null? right-node) -1 (hash-ref height-map (TreeNode-val right-node)))))

      (when (not (null? left-node))
        (let ((new-max-for-left
               (max
                (+ max-height-from-above 1)
                (if (not (null? right-node))
                    (+ right-subtree-height 2)
                    -1))))
          (dfs2 left-node new-max-for-left)))

      (when (not (null? right-node))
        (let ((new-max-for-right
               (max
                (+ max-height-from-above 1)
                (if (not (null? left-node))
                    (+ left-subtree-height 2)
                    -1))))
          (dfs2 right-node new-max-for-right))))))

(define (get-height-of-binary-tree-after-subtree-removal-queries root queries)
  (set! height-map (make-hash))
  (set! ans-map (make-hash))

  (dfs1 root)
  (dfs2 root -1)

  (map (lambda (q-val) (hash-ref ans-map q-val)) queries))