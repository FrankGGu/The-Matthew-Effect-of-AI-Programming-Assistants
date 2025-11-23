(define (get-intersection-node headA headB)
  (let loop ([a headA] [b headB])
    (cond
      [(equal? a b) a]
      [(and (null? a) (null? b)) #f]
      [(null? a) (loop headB (cdr b))]
      [(null? b) (loop (cdr a) headA)]
      [else (loop (cdr a) (cdr b))])))