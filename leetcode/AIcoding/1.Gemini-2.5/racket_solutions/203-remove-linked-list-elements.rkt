(define-struct ListNode (val next))

(define (remove-elements head val)
  (cond
    [(null? head) null]
    [(= (ListNode-val head) val)
     (remove-elements (ListNode-next head) val)]
    [else
     (ListNode (ListNode-val head)
               (remove-elements (ListNode-next head) val))]))