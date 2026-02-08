(define/contract (average-value nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([nums nums] [sum 0] [count 0])
    (cond
      [(null? nums) (if (zero? count) 0 (quotient sum count))]
      [(and (even? (car nums)) (zero? (modulo (car nums) 3)))
       (loop (cdr nums) (+ sum (car nums)) (add1 count))]
      [else (loop (cdr nums) sum count)])))