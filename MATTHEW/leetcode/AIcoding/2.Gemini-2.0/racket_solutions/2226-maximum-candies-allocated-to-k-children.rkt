(define (maximum-candies candies k)
  (define (possible? mid)
    (let loop ([ls candies] [count 0])
      (cond
        [(null? ls) (>= count k)]
        [else (let ([q (quotient (car ls) mid)])
                (if (= q 0)
                    (loop (cdr ls) count)
                    (loop (cdr ls) (+ count q))))])))

  (let ([sum (apply + candies)])
    (if (< sum k)
        0
        (let loop ([low 1] [high (quotient sum k)])
          (cond
            [(>= low high)
             (if (possible? high) high 0)]
            [else
             (let ([mid (quotient (+ low high 1) 2)])
               (if (possible? mid)
                   (loop mid high)
                   (loop low (- mid 1))))])))))