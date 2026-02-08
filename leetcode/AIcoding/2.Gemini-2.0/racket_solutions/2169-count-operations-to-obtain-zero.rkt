(define (count-operations num1 num2)
  (cond
    [(equal? num1 0) 0]
    [(equal? num2 0) 0]
    [(>= num1 num2) (+ 1 (count-operations (- num1 num2) num2))]
    [else (+ 1 (count-operations num1 (- num2 num1)))]))