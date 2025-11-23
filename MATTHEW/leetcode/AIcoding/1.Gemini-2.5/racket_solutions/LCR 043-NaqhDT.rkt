#lang racket

(define-struct TreeNode (val left right) #:mutable)

(require data/queue)

(define-struct CBTInserter (root q))

(define (CBTInserter root-node)
  (define q (make-queue))      ; This queue stores nodes that are not yet full (potential parents).
  (define bfs-q (make-queue))  ; This temporary queue is used for the initial BFS traversal.

  ;; If the root-node is not #f (i.e., the tree is not empty), start the BFS.
  (when root-node
    (enqueue! bfs-q root-node)

    ;; Perform a BFS traversal to populate the 'q' with all nodes that have less than two children.
    (let loop ()
      (unless (queue-empty? bfs-q)
        (define current-node (dequeue! bfs-q))

        ;; If the current-node has an empty left or right child, it's a candidate for future insertions.
        (when (or (not (TreeNode-left current-node)) (not (TreeNode-right current-node)))
          (enqueue! q current-node))

        ;; Enqueue children for the BFS traversal.
        (when (TreeNode-left current-node)
          (enqueue! bfs-q (TreeNode-left current-node)))
        (when (TreeNode-right current-node)
          (enqueue! bfs-q (TreeNode-right current-node)))
        (loop))))

  ;; Return a new CBTInserter instance with the original root and the populated queue.
  (CBTInserter root-node q))

(define (insert inserter v)
  (define q (CBTInserter-q inserter))
  (define parent-node (queue-front q)) ; Get the next available parent node from the front of the queue.

  ;; Create the new node.
  (define new-node (TreeNode v #f #f))

  ;; Insert the new node as either the left or right child of the parent-node.
  (cond
    [(not (TreeNode-left parent-node)) ; If the left child is empty, insert there.
     (set-TreeNode-left! parent-node new-node)]
    [else ; Otherwise, the right child must be empty (due to complete binary tree property).
     (set-TreeNode-right! parent-node new-node)])

  ;; The newly inserted node is also a potential parent for future insertions, so add it to the queue.
  (enqueue! q new-node)

  ;; If the parent-node now has both its left and right children, it is full.
  ;; Remove it from the front of the queue of potential parents.
  (when (and (TreeNode-left parent-node) (TreeNode-right parent-node))
    (dequeue! q))

  ;; Return the value of the parent node.
  (TreeNode-val parent-node))

(define (get_root inserter)
  (CBTInserter-root inserter))