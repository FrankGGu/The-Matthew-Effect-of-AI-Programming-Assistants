(define (min-cost chips)
  (let ([even (length (filter (lambda (x) (= (modulo x 2) 0)) chips))]
        [odd (length (filter (lambda (x) (= (modulo x 2) 1)) chips))])
    (min even odd)))

(min-cost '(1 2 3 4 5))