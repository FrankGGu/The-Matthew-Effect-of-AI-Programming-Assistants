(struct TreeNode (val left right))

(define (average-of-levels root)
  (if (eq? root #f)
      (list)
      (let loop ((q (list root)) ; q holds nodes for the current level
                 (result-acc (list))) ; Accumulator for results, will be reversed at end
        (if (null? q)
            (reverse result-acc) ; Reverse the accumulated results
            (let* ((level-size (length q)))
              (let calculate-level-data ((nodes-to-process q)
                                         (current-sum 0.0)
                                         (next-level-children (list)))
                (if (null? nodes-to-process)
                    (cons current-sum next-level-children)
                    (let* ((curr (car nodes-to-process))
                           (left-child (TreeNode-left curr))
                           (right-child (TreeNode-right curr)))

                      (let ((updated-next-level-children
                             (cond
                               ((and (not (eq? left-child #f)) (not (eq? right-child #f)))
                                (cons left-child (cons right-child next-level-children)))
                               ((not (eq? left-child #f))
                                (cons left-child next-level-children))
                               ((not (eq? right-child #f))
                                (cons right-child next-level-children))
                               (else next-level-children))))

                        (calculate-level-data (cdr nodes-to-process)
                                              (+ current-sum (TreeNode-val curr))
                                              updated-next-level-children))))))
                (let ((level-data (calculate-level-data q 0.0 (list))))
                  (let ((sum (car level-data))
                        (children (cdr level-data)))
                    (loop (reverse children)
                          (cons (/ sum level-size) result-acc))))))))))