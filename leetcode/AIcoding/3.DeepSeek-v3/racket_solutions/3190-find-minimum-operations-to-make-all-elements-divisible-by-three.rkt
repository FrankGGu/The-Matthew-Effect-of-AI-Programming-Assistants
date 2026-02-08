(define (min-operations nums)
  (let loop ([nums nums] [count 0])
    (cond
      [(null? nums) count]
      [else
       (let ([remainder (modulo (car nums) 3)])
       (cond
         [(= remainder 0) (loop (cdr nums) count)]
         [else (loop (cdr nums) (+ count (- 3 remainder)))]))]))