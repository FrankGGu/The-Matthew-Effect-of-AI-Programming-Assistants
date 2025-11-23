#lang racket

(define (dfs node max-dist)
  (if (null? node)
      ;; If node is null, no pairs, no leaves. Return empty counts.
      (list 0 (make-vector (+ max-dist 1) 0))
      (if (and (null? (TreeNode-left node)) (null? (TreeNode-right node)))
          ;; If node is a leaf, it contributes 0 pairs within its own subtree.
          ;; It is at distance 1 from itself.
          (let ((counts (make-vector (+ max-dist 1) 0)))
            (vector-set! counts 1 1)
            (list 0 counts))
          ;; If node is an internal node
          (let* ((left-res (dfs (TreeNode-left node) max-dist))
                 (left-pairs (car left-res))
                 (left-counts (cadr left-res))

                 (right-res (dfs (TreeNode-right node) max-dist))
                 (right-pairs (car right-res))
                 (right-counts (cadr right-res))

                 ;; Initialize total pairs with pairs found in left and right subtrees
                 (current-total-pairs (+ left-pairs right-pairs))
                 ;; Initialize new counts vector for the current node
                 (new-counts (make-vector (+ max-dist 1) 0)))

            ;; Calculate new good pairs formed between leaves in the left subtree
            ;; and leaves in the right subtree.
            (for* ((d1 (in-range 1 (+ max-dist 1))) ; Iterate distances from 1 to max-dist
                   (c1 (vector-ref left-counts d1))
                   #:when (> c1 0)) ; Only consider distances with actual leaves
              (for* ((d2 (in-range 1 (+ max-dist 1)))
                     (c2 (vector-ref right-counts d2))
                     #:when (> c2 0))
                ;; If the sum of distances is within the allowed `max-dist`
                (when (<= (+ d1 d2) max-dist)
                  (set! current-total-pairs (+ current-total-pairs (* c1 c2))))))

            ;; Construct the `new-counts` vector for the current node.
            ;; Distances from children's leaves are incremented by 1 (for the current node).
            ;; We only care about distances up to `max-dist`.
            (for ((d (in-range 1 max-dist))) ; d goes from 1 to max-dist - 1
              (vector-set! new-counts (+ d 1)
                           (+ (vector-ref new-counts (+ d 1))
                              (vector-ref left-counts d)
                              (vector-ref right-counts d))))

            ;; Return the total good pairs for this subtree and its leaf distance counts.
            (list current-total-pairs new-counts)))))

(define (num-good-leaf-nodes-pairs root distance)
  ;; The result of dfs is a list (total-pairs, counts-vector).
  ;; We only need the total-pairs.
  (car (dfs root distance)))