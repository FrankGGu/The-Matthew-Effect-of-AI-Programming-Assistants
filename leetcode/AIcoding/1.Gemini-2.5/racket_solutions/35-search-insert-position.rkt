(define (search-insert nums target)
  (let loop ((low 0)
             (high (- (vector-length nums) 1)))
    (if (> low high)
        low
        (let* ((mid (+ low (quotient (- high low) 2)))
               (mid-val (vector-ref nums mid)))
          (cond
            ((= mid-val target) mid)
            ((< mid-val target) (loop (+ mid 1) high))
            (else (loop low (- mid 1))))))))