(define (is-perfect-square num)
  (define (binary-search low high)
    (cond
      [(> low high) #f]
      [else
       (let* ([mid (floor (+ low high) 2)]
              [square (* mid mid)])
         (cond
           [(= square num) #t]
           [(< square num) (binary-search (+ mid 1) high)]
           [else (binary-search low (- mid 1))]))]))
  (binary-search 1 num))