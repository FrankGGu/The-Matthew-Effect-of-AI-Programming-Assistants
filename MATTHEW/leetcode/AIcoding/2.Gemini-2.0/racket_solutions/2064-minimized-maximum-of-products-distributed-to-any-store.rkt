(define (minimized-maximum n quantities)
  (define (possible? max-val)
    (let loop ([quantities quantities] [stores-used 0])
      (cond
        [(null? quantities) (<= stores-used n)]
        [else
         (let ([q (car quantities)])
           (let ([num-stores (quotient q max-val)])
             (if (>= q max-val)
                 (loop (cdr quantities) (+ stores-used num-stores))
                 (loop (cdr quantities) (+ stores-used 1)))))])))

  (define (binary-search low high)
    (cond
      [(> low high) low]
      [else
       (let ([mid (quotient (+ low high) 2)])
         (if (possible? mid)
             (binary-search low (- mid 1))
             (binary-search (+ mid 1) high)))]))

  (binary-search (apply min quantities) (apply max quantities)))