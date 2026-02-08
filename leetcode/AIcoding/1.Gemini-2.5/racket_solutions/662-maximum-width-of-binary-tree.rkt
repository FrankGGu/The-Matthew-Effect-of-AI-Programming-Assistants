#lang racket

(define (width-of-binary-tree root)
  (if (not root) 0)

  ;; Helper function to add children of a node to the next-level-q-rev.
  ;; Children are added in reverse order (right then left) so that when
  ;; next-level-q-rev is reversed later, they will be in the correct
  ;; left-to-right order for the next level's queue.
  (define (add-children next-q-rev node pos)
    (let ((q-with-right (if (TreeNode-right node)
                            (cons (cons (TreeNode-right node) (+ (* 2 pos) 1)) next-q-rev)
                            next-q-rev)))
      (if (TreeNode-left node)
          (cons (cons (TreeNode-left node) (* 2 pos)) q-with-right)
          q-with-right)))

  ;; Main BFS loop.
  ;; `q` holds the (node . position) pairs for the current level.
  ;; `max-w` stores the maximum width found so far.
  (let loop ((q (list (cons root 1))) ; Initialize queue with root at position 1
             (max-w 0))
    (if (empty? q)
        max-w ; If queue is empty, no more levels to process, return max-w
        (let* ((level-size (length q)) ; Number of nodes in the current level
               (first-pos (cdr (car q)))) ; Position of the leftmost node in the current level

          ;; Inner loop to process all nodes of the current level.
          ;; `i` is the counter for nodes processed in the current level.
          ;; `current-level-q` is the remaining part of `q` to process for this level.
          ;; `next-level-q-rev` accumulates children for the next level (in reverse order).
          ;; `last-pos` tracks the position of the rightmost node processed in this level.
          (let process-level ((i 0)
                              (current-level-q q)
                              (next-level-q-rev '())
                              (last-pos first-pos)) ; Initialize last-pos with first-pos for a single-node level
            (if (= i level-size)
                ;; All nodes of the current level have been processed.
                ;; Calculate current level's width and update max-w.
                ;; Then, prepare the queue for the next level and continue the main loop.
                (loop (reverse next-level-q-rev) ; Reverse to get correct left-to-right order for next level
                      (max max-w (+ (- last-pos first-pos) 1)))
                ;; Process the current node from `current-level-q`.
                (let* ((current-pair (car current-level-q))
                       (node (car current-pair))
                       (pos (cdr current-pair)))
                  (process-level (+ i 1)
                                 (cdr current-level-q) ; Dequeue current node
                                 (add-children next-level-q-rev node pos) ; Add children to next level's queue
                                 pos)))))))) ; Update last-pos with the current node's position