(define (search-insert nums target)
  (let* ([n (vector-length nums)]
         [low 0]
         [high (- n 1)])
    (let loop ([l low] [h high])
      (cond
        [(> l h) l]
        [else
         (let ([mid (+ l (quotient (- h l) 2))])
           (let ([mid-val (vector-ref nums mid)])
             (cond
               [(= mid-val target) mid]
               [(< mid-val target) (loop (+ mid 1) h)]
               [else (loop l (- mid 1))])))])
    ))