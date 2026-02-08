(define (swap-nodes head k)
  (let* ([node1 #f]
         [node2 #f]
         [curr head])

    (for ([_ (in-range 1 k)])
      (set! curr (ListNode-next curr)))
    (set! node1 curr)

    (set! node2 head)
    (set! curr node1)

    (while (not (null? (ListNode-next curr)))
      (set! curr (ListNode-next curr))
      (set! node2 (ListNode-next node2)))

    (let ([temp (ListNode-val node1)])
      (set-ListNode-val! node1 (ListNode-val node2))
      (set-ListNode-val! node2 temp))

    head))