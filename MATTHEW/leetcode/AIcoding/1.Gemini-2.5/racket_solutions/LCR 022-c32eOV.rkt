(struct ListNode (val next))

(define (detectCycle head)
  (let loop-detect ((slow head) (fast head))
    (if (or (null? fast) (null? (ListNode-next fast)))
        null
        (let* ((new-slow (ListNode-next slow))
               (new-fast (ListNode-next (ListNode-next fast))))
          (if (eq? new-slow new-fast)
              (let loop-find-start ((p1 head) (p2 new-slow))
                (if (eq? p1 p2)
                    p1
                    (loop-find-start (ListNode-next p1) (ListNode-next p2))))
              (loop-detect new-slow new-fast))))))