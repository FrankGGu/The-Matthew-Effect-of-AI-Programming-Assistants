#lang racket

(struct TreeNode (val left right))

(define (zigzag-level-order root)
  (if (eq? root null)
      '()
      (let loop ((queue (list root)) ; Queue of nodes for the current level
                 (result '())       ; Accumulated list of level lists (reversed order of levels)
                 (left-to-right? #t)) ; Direction flag for the current level
        (if (empty? queue)
            (reverse result) ; All levels processed, reverse the result to get correct level order
            (let* ((level-size (length queue))) ; Number of nodes in the current level
              ;; Process all nodes in the current level
              (let process-level ((q-rem queue)            ; Remaining nodes in current level's queue
                                  (count level-size)       ; Number of nodes left to process in current level
                                  (current-level-vals '()) ; Values for the current level (accumulated in reverse order of processing)
                                  (next-queue-acc '()))    ; Children for the next level's queue (accumulated in reverse order of adding)
                (if (zero? count)
                    ;; Current level finished processing
                    (let* ((final-current-level (if left-to-right?
                                                    (reverse current-level-vals) ; Reverse for left-to-right order
                                                    current-level-vals)))        ; Already in right-to-left order due to consing
                      ;; Continue to the next level
                      (loop (reverse next-queue-acc) ; Reverse accumulated children to get correct order for next level's queue
                            (cons final-current-level result) ; Add current level to result (cons for efficiency, reverse at the very end)
                            (not left-to-right?)))            ; Toggle direction for the next level
                    ;; Process one node from the current level
                    (let* ((node (car q-rem))
                           (rest-q (cdr q-rem))
                           ;; Accumulate children for the next level's queue.
                           ;; Add right child then left child. When 'next-queue-acc' is reversed later,
                           ;; it will result in left child appearing before right child for each parent.
                           (updated-next-queue-acc
                             (let ((acc next-queue-acc))
                               (let ((acc-with-right (if (not (eq? (TreeNode-right node) null))
                                                         (cons (TreeNode-right node) acc)
                                                         acc)))
                                 (if (not (eq? (TreeNode-left node) null))
                                     (cons (TreeNode-left node) acc-with-right)
                                     acc-with-right)))))
                      (process-level rest-q
                                     (sub1 count)
                                     (cons (TreeNode-val node) current-level-vals) ; Add current node's value (in reverse)
                                     updated-next-queue-acc))))))))