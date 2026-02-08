(define (distMoney m n)
  (if (= n 0)
      (if (= m 0) 1 0)
      (let loop ((money m) (children n))
        (cond
          [(< money children) 0]
          [(= children 1) (if (<= money 8) 1 0)]
          [else
           (let ((max-give (min 8 money)))
             (for/sum ((i (in-range 0 (+ 1 max-give))))
               (loop (- money i) (- children 1))))]))))

(define (distributeMoney m n)
  (distMoney m n))