(define (find-min nums)
  (let* ([n (length nums)]
         [arr (list->vector nums)])
    (let loop ([low 0] [high (- n 1)])
      (if (= low high)
          (vector-ref arr low)
          (let ([mid (+ low (quotient (- high low) 2))])
            (cond
              [(< (vector-ref arr mid) (vector-ref arr high))
               (loop low mid)]
              [(> (vector-ref arr mid) (vector-ref arr high))
               (loop (+ mid 1) high)]
              [else ; (vector-ref arr mid) == (vector-ref arr high)
               (loop low (- high 1))]))))))