(struct ListNode (val next))

(define (merge-two-lists list1 list2)
  (cond
    [(not list1) list2]
    [(not list2) list1]
    [(<= (ListNode-val list1) (ListNode-val list2))
     (ListNode (ListNode-val list1)
               (merge-two-lists (ListNode-next list1) list2))]
    [else
     (ListNode (ListNode-val list2)
               (merge-two-lists list1 (ListNode-next list2)))]))