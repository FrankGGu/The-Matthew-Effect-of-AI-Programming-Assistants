(define (clumsy N)
  (define (helper n acc stack op)
    (cond
      [(zero? n) (apply + (cons acc stack))]
      [(= op 0) (helper (sub1 n) (* acc n) stack (modulo (add1 op) 4))]
      [(= op 1) (helper (sub1 n) (quotient acc n) stack (modulo (add1 op) 4))]
      [(= op 2) (helper (sub1 n) (+ acc n) stack (modulo (add1 op) 4))]
      [else (helper (sub1 n) (- n) (cons acc stack) (modulo (add1 op) 4))]))
  (helper N 1 '() 0))