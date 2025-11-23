(define (cycle-length-queries n queries)
  (define (lca a b)
    (cond
      [(< a b) (lca b a)]
      [(= a b) a]
      [else
       (let loop ([a a] [b b] [dist 0])
         (cond
           [(= a b) dist]
           [(> a b) (loop (quotient a 2) b (+ dist 1))]
           [else (loop a (quotient b 2) (+ dist 1))]))]))

  (map (lambda (q) (+ 1 (lca (car q) (cadr q)))) queries))