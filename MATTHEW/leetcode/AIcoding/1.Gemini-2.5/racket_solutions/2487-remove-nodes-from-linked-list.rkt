(struct ListNode (val next))

(define (remove-nodes head)
  (define (helper node max-val-from-right)
    (if (null? node)
        (values null max-val-from-right)
        (let-values (((rest-list new-max-from-right) (helper (ListNode-next node) max-val-from-right)))
          (if (>= (ListNode-val node) new-max-from-right)
              (values (ListNode (ListNode-val node) rest-list) (ListNode-val node))
              (values rest-list new-max-from-right)))))

  (if (null? head)
      null
      (let-values (((final-list _) (helper head 0)))
        final-list)))