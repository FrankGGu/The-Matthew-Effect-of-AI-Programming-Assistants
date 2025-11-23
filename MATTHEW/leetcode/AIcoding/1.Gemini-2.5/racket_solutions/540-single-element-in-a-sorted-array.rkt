(define (single-non-duplicate nums)
  (let* ([n (vector-length nums)]
         [low 0]
         [high (- n 1)])
    (let loop ([l low] [h high])
      (if (= l h)
          (vector-ref nums l)
          (let* ([mid (+ l (quotient (- h l) 2))]
                 [mid (if (odd? mid) (- mid 1) mid)])
            (if (= (vector-ref nums mid) (vector-ref nums (+ mid 1)))
                (loop (+ mid 2) h)
                (loop l mid)))))))