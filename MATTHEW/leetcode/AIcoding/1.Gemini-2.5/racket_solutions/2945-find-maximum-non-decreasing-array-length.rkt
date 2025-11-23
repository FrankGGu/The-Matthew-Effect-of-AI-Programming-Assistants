(define (find-maximum-non-decreasing-array-length nums)
  (define n (length nums))
  (if (= n 0)
      0
      (begin
        (define tails (make-vector n 0))
        (define len 0)

        (define (binary-search target)
          (let loop ([low 0] [high (- len 1)] [ans len])
            (if (> low high)
                ans
                (let ([mid (+ low (quotient (- high low) 2))])
                  (if (>= (vector-ref tails mid) target)
                      (loop low (- mid 1) mid)
                      (loop (+ mid 1) high ans))))))

        (for-each
         (lambda (num)
           (let ([idx (binary-search num)])
             (vector-set! tails idx num)
             (when (= idx len)
               (set! len (+ len 1)))))
         nums)

        len)))