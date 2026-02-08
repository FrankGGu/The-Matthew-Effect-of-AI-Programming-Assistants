(define (count-operations num1 num2)
  (let loop ([n1 num1]
             [n2 num2]
             [count 0])
    (cond
      [(or (zero? n1) (zero? n2)) count]
      [(>= n1 n2) (loop (- n1 n2) n2 (add1 count))]
      [else (loop n1 (- n2 n1) (add1 count))])))