(define (largestSumAfterKNegations nums k)
  (let* ([sorted-nums (sort nums <)]
         [n (length nums)])
    (let loop ([nums sorted-nums] [k k])
      (cond
        [(zero? k) (apply + nums)]
        [(empty? nums) 0]
        [(< (car nums) 0) (loop (cons (- (car nums)) (cdr nums)) (- k 1))]
        [else (if (odd? k)
                  (let ([min-val (min (car nums) (if (not (empty? (cdr nums))) (cadr nums) (car nums)))])
                    (cond
                      [(= min-val (car nums)) (apply + (cons (- (car nums)) (cdr nums)))]
                      [else (apply + (cons (car nums) (cons (- (cadr nums)) (cddr nums))))]))
                  (apply + nums))]
        ))))