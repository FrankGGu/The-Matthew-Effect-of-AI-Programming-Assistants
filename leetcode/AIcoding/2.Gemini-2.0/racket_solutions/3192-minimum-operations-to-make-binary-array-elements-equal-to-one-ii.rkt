(define (minOperations nums p)
  (let* ([n (length nums)]
         [dp (make-vector (+ n 1) 0)])
    (for ([i (in-range (- n 1) -1 -1)])
      (if (= (vector-ref nums i) 1)
          (vector-set! dp i (vector-ref dp (+ i 1)))
          (let ([op1 (+ 1 (if (>= (+ i p) n) 0 (vector-ref dp (+ i p))))]
                [op2 (vector-ref dp (+ i 1))])
            (vector-set! dp i op1))))
    (vector-ref dp 0)))