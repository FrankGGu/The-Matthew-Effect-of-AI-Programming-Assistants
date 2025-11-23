(define (find-difference n m)
  (let ((num1 (for/sum ((i (in-range 1 (add1 n))))
                (if (= (modulo i m) 0)
                    0
                    i)))
        (num2 (for/sum ((i (in-range 1 (add1 n))))
                (if (= (modulo i m) 0)
                    i
                    0))))
    (- num1 num2)))