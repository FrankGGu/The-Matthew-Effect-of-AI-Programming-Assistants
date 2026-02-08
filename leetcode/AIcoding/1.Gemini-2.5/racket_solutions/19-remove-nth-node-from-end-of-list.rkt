(struct ListNode (val next) #:mutable)

(define (remove-nth-from-end head n)
  (define dummy (ListNode 0 head))
  (define slow dummy)
  (define fast dummy)

  (for ([_ (in-range n)])
    (set! fast (ListNode-next fast)))

  (while (ListNode-next fast)
    (set! slow (ListNode-next slow))
    (set! fast (ListNode-next fast)))

  (set-ListNode-next! slow (ListNode-next (ListNode-next slow)))

  (ListNode-next dummy))