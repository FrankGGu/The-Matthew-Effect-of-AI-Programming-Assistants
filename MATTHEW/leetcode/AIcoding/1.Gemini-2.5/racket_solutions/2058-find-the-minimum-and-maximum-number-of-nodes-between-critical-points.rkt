(struct ListNode (val next))

(define (find-min-max-nodes head)
  (if (or (null? head)
          (null? (ListNode-next head))
          (null? (ListNode-next (ListNode-next head))))
      (list -1 -1)
      (let loop ((prev-node head)
                 (curr-node (ListNode-next head))
                 (node-index 1)
                 (first-critical-point-index -1)
                 (last-critical-point-index -1)
                 (min-dist +inf.0))
        (let ((next-node (ListNode-next curr-node)))
          (if (null? next-node)
              ;; End of list, process results
              (if (or (= first-critical-point-index -1)
                      (= first-critical-point-index last-critical-point-index))
                  (list -1 -1) ; Less than 2 critical points
                  (list min-dist (- last-critical-point-index first-critical-point-index)))
              ;; Continue traversal
              (let* ((val-prev (ListNode-val prev-node))
                     (val-curr (ListNode-val curr-node))
                     (val-next (ListNode-val next-node))
                     (is-critical-point (or (and (< val-prev val-curr) (> val-curr val-next))
                                            (and (> val-prev val-curr) (< val-curr val-next)))))
                (if is-critical-point
                    (loop curr-node
                          next-node
                          (+ node-index 1)
                          (if (= first-critical-point-index -1) node-index first-critical-point-index)
                          node-index
                          (if (= last-critical-point-index -1)
                              min-dist
                              (min min-dist (- node-index last-critical-point-index))))
                    (loop curr-node
                          next-node
                          (+ node-index 1)
                          first-critical-point-index
                          last-critical-point-index
                          min-dist))))))))