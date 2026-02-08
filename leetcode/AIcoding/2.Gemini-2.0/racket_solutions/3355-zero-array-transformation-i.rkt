(define (zeros-array-transformation (nums : (Listof Integer))) : Boolean
  (if (null? nums)
      #t
      (let loop ([nums nums] [count 0])
        (cond
          [(null? nums) #t]
          [(zero? (car nums)) (loop (cdr nums) (+ count 1))]
          [else (if (positive? count)
                    (loop (cdr nums) count)
                    #f)]))))