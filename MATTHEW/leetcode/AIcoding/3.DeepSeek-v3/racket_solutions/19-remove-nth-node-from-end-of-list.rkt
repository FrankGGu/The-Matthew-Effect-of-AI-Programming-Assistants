(define/contract (remove-nth-from-end head n)
  (-> (or/c list? null?) exact-positive-integer? (or/c list? null?))
  (let loop ([fast head] [slow head] [count 0])
    (cond
      [(null? fast) (if (= count n) (cdr slow) head)]
      [(< count (add1 n)) (loop (cdr fast) slow (add1 count))]
      [else (loop (cdr fast) (cdr slow) count])))