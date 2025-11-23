(define (maximum-top (nums k))
  (define n (length nums))
  (cond
    [(= n 1) (if (even? k) (car nums) -1)]
    [(< k n)
     (let* ([max-val (apply max (take nums (- k 1)))]
            [kth-val (list-ref nums k)])
       (max max-val kth-val))]
    [(= k n) (apply max (drop-right nums 1))]
    [else (apply max nums)]))