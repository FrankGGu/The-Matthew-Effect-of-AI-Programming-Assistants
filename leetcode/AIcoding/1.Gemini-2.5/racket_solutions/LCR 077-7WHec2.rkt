(define (sortList head)
  (if (or (not head) (not (ListNode-next head)))
      head
      (let-values (((left-half right-half) (split-list head)))
        (let ((sorted-left (sortList left-half))
              (sorted-right (sortList right-half)))
          (merge-two-lists sorted-left sorted-right)))))

(define (split-list head)
  (let loop ((slow head) (fast head) (prev-slow null))
    (if (or (not fast) (not (ListNode-next fast)))
        (begin
          (set-ListNode-next! prev-slow null)
          (values head slow))
        (loop (ListNode-next slow)
              (ListNode-next (ListNode-next fast))
              slow))))

(define (merge-two-lists l1 l2)
  (let ((dummy (ListNode 0 null)))
    (let loop ((curr dummy) (p1 l1) (p2 l2))
      (cond
        ((not p1)
         (set-ListNode-next! curr p2)
         (ListNode-next dummy))
        ((not p2)
         (set-ListNode-next! curr p1)
         (ListNode-next dummy))
        ((< (ListNode-val p1) (ListNode-val p2))
         (set-ListNode-next! curr p1)
         (loop (ListNode-next curr) (ListNode-next p1) p2))
        (else
         (set-ListNode-next! curr p2)
         (loop (ListNode-next curr) p1 (ListNode-next p2)))))))