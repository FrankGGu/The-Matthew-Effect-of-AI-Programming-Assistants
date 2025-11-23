(struct ListNode (val next) #:mutable)

(define (reorder-list head)
  (when (and head (ListNode-next head))
    ;; Step 1: Find the middle of the list
    (let loop-find-middle ((slow head) (fast head))
      (if (and (ListNode-next fast) (ListNode-next (ListNode-next fast)))
          (loop-find-middle (ListNode-next slow) (ListNode-next (ListNode-next fast)))
          ;; slow is the end of the first half
          (let* ((first-half-head head)
                 (second-half-head (ListNode-next slow)))
            ;; Step 2: Split the list into two halves
            (set-ListNode-next! slow #f)

            ;; Step 3: Reverse the second half
            (define (reverse-list node)
              (let loop-reverse ((curr node) (prev #f))
                (if curr
                    (let ((temp (ListNode-next curr)))
                      (set-ListNode-next! curr prev)
                      (loop-reverse temp curr))
                    prev)))

            (let ((l1 first-half-head)
                  (l2 (reverse-list second-half-head)))

              ;; Step 4: Merge the two halves
              (let loop-merge ((curr-l1 l1) (curr-l2 l2))
                (when (and curr-l1 curr-l2)
                  (let ((temp1 (ListNode-next curr-l1))
                        (temp2 (ListNode-next curr-l2)))
                    (set-ListNode-next! curr-l1 curr-l2)
                    (set-ListNode-next! curr-l2 temp1)
                    (loop-merge temp1 temp2)))))))))
  head)