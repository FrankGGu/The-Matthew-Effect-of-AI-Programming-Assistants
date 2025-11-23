(struct ListNode (val next))

(define (pairSum head)
  (define (reverse lst)
    (define (rev-iter lst acc)
      (if (null? lst)
          acc
          (rev-iter (ListNode-next lst) (cons (ListNode-val lst) acc))))
    (rev-iter lst '()))

  (define (get-first-half lst)
    (define (iter slow fast)
      (if (null? fast)
          slow
          (iter (ListNode-next slow) (ListNode-next (ListNode-next fast)))))
    (iter lst lst))

  (define first-half (get-first-half head))
  (define second-half (reverse (get-first-half (ListNode-next first-half))))

  (define (max-twin-sum lst1 lst2)
    (if (or (null? lst1) (null? lst2))
        0
        (max (+ (ListNode-val lst1) (ListNode-val lst2))
             (max-twin-sum (ListNode-next lst1) (ListNode-next lst2)))))

  (max-twin-sum first-half second-half))