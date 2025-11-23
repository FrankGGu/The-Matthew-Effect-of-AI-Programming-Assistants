(define/contract (training-plan head k)
  (-> (or/c list? #f) exact-integer? (or/c list? #f))
  (let loop ([fast head] [slow head] [count 0])
    (cond
      [(null? fast) (if (>= count k) slow #f)]
      [(< count k) (loop (cdr fast) slow (add1 count))]
      [else (loop (cdr fast) (cdr slow) count)])))