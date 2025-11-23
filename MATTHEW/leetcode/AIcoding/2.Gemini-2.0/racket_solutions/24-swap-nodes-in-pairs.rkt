(define (swap-pairs head)
  (cond
    [(or (null? head) (null? (cdr head))) head]
    [else
     (let* ([next (cdr head)]
            [next-next (cdr next)]
            [new-head next])
       (set-cdr! head next-next)
       (set-cdr! next head)
       (set-cdr! head (swap-pairs next-next))
       new-head)]))