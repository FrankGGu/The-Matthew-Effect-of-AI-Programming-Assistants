(define (maximum-top nums k)
  (cond [(= k 0) (car nums)]
        [(= (length nums) 1) (if (= k 1) -1 (car nums))]
        [else
         (let ([n (length nums)])
           (if (<= k n)
               (apply max (take nums (min k n)))
               (apply max (append (take nums (- n 1)) (list (last nums))))))]))