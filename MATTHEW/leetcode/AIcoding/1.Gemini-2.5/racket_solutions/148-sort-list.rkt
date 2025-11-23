(define (get-middle head)
  (let loop ((slow head) (fast head) (prev-slow null))
    (if (or (null? fast) (null? (ListNode-next fast)))
        prev-slow
        (loop (ListNode-next slow)
              (ListNode-next (ListNode-next fast))
              slow))))

(define (merge-two-lists l1 l2)
  (let* ((dummy (ListNode 0 null))
         (curr dummy))
    (let loop ((node1 l1) (node2 l2))
      (cond
        ((null? node1) (set-ListNode-next! curr node2))
        ((null? node2) (set-ListNode-next! curr node1))
        ((< (ListNode-val node1) (ListNode-val node2))
         (set-ListNode-next! curr node1)
         (set! curr (ListNode-next curr))
         (loop (ListNode-next node1) node2))
        (else
         (set-ListNode-next! curr node2)
         (set! curr (ListNode-next curr))
         (loop node1 (ListNode-next node2)))))
    (ListNode-next dummy)))

(define (sort-list head)
  (if (or (null? head) (null? (ListNode-next head)))
      head
      (let* ((mid-prev (get-middle head))
             (second-half-head (ListNode-next mid-prev)))
        (set-ListNode-next! mid-prev null)
        (let ((sorted-first (sort-list head))
              (sorted-second (sort-list second-half-head)))
          (merge-two-lists sorted-first sorted-second)))))