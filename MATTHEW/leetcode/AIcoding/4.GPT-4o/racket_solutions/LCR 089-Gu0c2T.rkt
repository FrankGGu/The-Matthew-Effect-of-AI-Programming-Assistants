(define (rob nums)
  (define (helper nums)
    (define n (length nums))
    (cond
      [(= n 0) 0]
      [(= n 1) (car nums)]
      [else
       (let loop ([i 2] [prev1 (car nums)] [prev2 0])
         (if (= i n)
             (max prev1 prev2)
             (loop (+ i 1) (list-ref nums (- i 1)) (max prev1 prev2))))]))
  (if (= (length nums) 1)
      (car nums)
      (max (helper (cdr nums)) (helper (butlast nums)))))