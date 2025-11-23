(define-struct ListNode (val next))

(define (reorder-list head)
  (when (and head (ListNode-next head))
    (define mid (find-mid head))
    (define second-half (reverse (ListNode-next mid)))
    (set! (ListNode-next mid) '())
    (merge head second-half)))

(define (find-mid head)
  (let loop ([slow head] [fast head])
    (if (or (null? fast) (null? (ListNode-next fast)))
        slow
        (loop (ListNode-next slow) (ListNode-next (ListNode-next fast))))))

(define (reverse head)
  (let loop ([prev '()] [curr head])
    (if (null? curr)
        prev
        (loop (cons (ListNode-val curr) prev) (ListNode-next curr)))))

(define (merge l1 l2)
  (if (null? l1)
      l2
      (if (null? l2)
          l1
          (let ([next1 (ListNode-next l1)]
                [next2 (ListNode-next l2)])
            (set! (ListNode-next l1) l2)
            (set! (ListNode-next l2) (merge next1 next2))
            l1))))