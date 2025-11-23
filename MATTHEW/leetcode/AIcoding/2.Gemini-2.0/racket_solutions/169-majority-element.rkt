(define (majority-element nums)
  (let loop ([nums nums] [candidate #f] [count 0])
    (cond
      [(null? nums) candidate]
      [(zero? count) (loop (cdr nums) (car nums) 1)]
      [(equal? (car nums) candidate) (loop (cdr nums) candidate (+ 1 count))]
      [else (loop (cdr nums) candidate (- count 1))])))