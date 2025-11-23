(define/contract (check-balanced-string s)
  (-> string? boolean?)
  (let loop ([chars (string->list s)] [balance 0])
    (cond
      [(null? chars) (zero? balance)]
      [(< balance 0) #f]
      [(char=? (car chars) #\() (loop (cdr chars) (add1 balance))]
      [else (loop (cdr chars) (sub1 balance))])))