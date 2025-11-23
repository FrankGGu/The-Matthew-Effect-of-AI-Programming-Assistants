(define (search nums target)
  (let loop ((low 0)
             (high (- (vector-length nums) 1)))
    (cond
      ((> low high) -1)
      (else
       (let* ((mid (+ low (quotient (- high low) 2)))
              (mid-val (vector-ref nums mid)))
         (cond
           ((= mid-val target) mid)
           ((< mid-val target) (loop (+ mid 1) high))
           (else (loop low (- mid 1)))))))))