(define (maximum-product nums k)
  (let loop ([nums (sort nums <)]
             [k k])
    (if (zero? k)
        (foldl * 1 nums)
        (let ([min-val (car nums)])
          (loop (sort (cons (add1 min-val) (cdr nums)) <) (sub1 k))))))