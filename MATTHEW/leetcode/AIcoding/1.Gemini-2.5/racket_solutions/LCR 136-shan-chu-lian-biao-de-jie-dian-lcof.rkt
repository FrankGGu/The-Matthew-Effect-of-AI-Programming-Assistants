(define (delete-node node)
  (let ((next-node (ListNode-next node)))
    (set-ListNode-val! node (ListNode-val next-node))
    (set-ListNode-next! node (ListNode-next next-node))))