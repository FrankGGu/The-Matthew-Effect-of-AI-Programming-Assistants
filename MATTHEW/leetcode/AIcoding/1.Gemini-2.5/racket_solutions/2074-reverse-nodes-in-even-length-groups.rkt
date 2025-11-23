(define-struct list-node (val next) #:mutable)

(define (reverse-nodes-in-even-length-groups head)
  (if (not head)
      head
      (let* ((dummy-head (list-node #f head)))
        (let loop ((current-node head)
                   (group-num 1)
                   (prev-group-tail dummy-head))
          (if (not current-node)
              (list-node-next dummy-head)
              (let* ((nodes-stack '()) ; Stores nodes in reverse order of appearance (N_k ... N_1)
                     (temp-current current-node)
                     (actual-k 0)
                     (first-node-in-group #f) ; N_1 (original head of the group)
                     (last-node-in-group #f))  ; N_k (original tail of the group)

                ;; Collect nodes into a list (nodes-stack will be in reverse order)
                (for ((i (in-range group-num))
                      #:when temp-current)
                  (when (zero? i)
                    (set! first-node-in-group temp-current))
                  (set! last-node-in-group temp-current)
                  (set! nodes-stack (cons temp-current nodes-stack))
                  (set! temp-current (list-node-next temp-current))
                  (set! actual-k (add1 actual-k)))

                (let ((next-node-after-group temp-current))
                  (let-values (((new-head new-tail)
                                (if (even? actual-k)
                                    ;; Reverse the group
                                    (let* ((nh (car nodes-stack)) ; N_k (new head)
                                           (nt first-node-in-group)) ; N_1 (new tail)
                                      ;; Link the nodes in reversed order
                                      (let link-loop ((nodes nodes-stack))
                                        (when (and (not (null? nodes)) (not (null? (cdr nodes))))
                                          (set-list-node-next! (car nodes) (cadr nodes))
                                          (link-loop (cdr nodes))))
                                      ;; The new tail (original head) points to the next group's head
                                      (set-list-node-next! nt next-node-after-group)
                                      (values nh nt))
                                    ;; Do not reverse the group
                                    (let* ((nh first-node-in-group) ; N_1 (new head)
                                           (nt last-node-in-group))  ; N_k (new tail)
                                      ;; The nodes are already linked in original order.
                                      ;; The new tail (original tail) points to the next group's head
                                      (set-list-node-next! nt next-node-after-group)
                                      (values nh nt)))))

                    ;; Connect the previous group's tail to the current group's new head
                    (set-list-node-next! prev-group-tail new-head)

                    ;; Continue to the next group
                    (loop next-node-after-group
                          (add1 group-num)
                          new-tail)))))))))