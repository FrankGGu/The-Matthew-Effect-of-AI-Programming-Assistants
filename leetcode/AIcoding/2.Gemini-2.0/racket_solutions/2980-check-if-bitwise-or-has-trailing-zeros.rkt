(define (has-trailing-zeros? nums)
  (let loop ([nums nums] [count 0])
    (cond
      [(null? nums) #f]
      [(= (modulo (car nums) 2) 0)
       (if (= count 1)
           #t
           (loop (cdr nums) (+ count 1)))]
      [else
       (loop (cdr nums) count)])))