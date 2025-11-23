(define (single-non-duplicate nums)
  (let* ([n (vector-length nums)]
         [low 0]
         [high (- n 1)])
    (let loop ([l low] [h high])
      (if (= l h)
          (vector-ref nums l)
          (let* ([mid (+ l (quotient (- h l) 2))]
                 [mid-val (vector-ref nums mid)])
            (if (even? mid)
                (if (= mid-val (vector-ref nums (+ mid 1)))
                    (loop (+ mid 2) h)
                    (loop l mid))
                (if (= mid-val (vector-ref nums (- mid 1)))
                    (loop (+ mid 1) h)
                    (loop l mid))))))))