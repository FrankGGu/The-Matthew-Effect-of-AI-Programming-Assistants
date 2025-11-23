(struct ListNode (val next))

(define (oddEvenList head)
  (if (or (null? head) (null? (ListNode-next head)))
      head
      (let loop ((odd head)
                 (even (ListNode-next head))
                 (evenHead even))
        (if (or (null? odd) (null? even))
            head
            (begin
              (set! (ListNode-next odd) (ListNode-next (ListNode-next odd)))
              (set! (ListNode-next even) (ListNode-next (ListNode-next even)))
              (loop (ListNode-next odd) (ListNode-next even) evenHead)))))