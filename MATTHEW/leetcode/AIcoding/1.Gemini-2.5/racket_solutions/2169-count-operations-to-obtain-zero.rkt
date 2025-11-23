(define (count-operations num1 num2)
  (let loop ((n1 num1) (n2 num2) (count 0))
    (cond
      ((or (= n1 0) (= n2 0))
       count)
      ((>= n1 n2)
       (loop (- n1 n2) n2 (+ count 1)))
      (else
       (loop n1 (- n2 n1) (+ count 1))))))