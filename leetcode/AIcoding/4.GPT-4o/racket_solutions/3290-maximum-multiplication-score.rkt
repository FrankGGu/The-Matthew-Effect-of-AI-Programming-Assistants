(define (maximum-multiplication-score nums mod k)
  (define n (length nums))
  (define (mod-mul a b) (mod (* a b) mod))
  (define (dp i j)
    (if (>= i n)
        0
        (if (= j k)
            (dp (+ i 1) 0)
            (max (mod-mul (list-ref nums i) (dp i (+ j 1)))
                 (dp (+ i 1) j)))))
  (dp 0 0))

(maximum-multiplication-score '(1 2 3 4) 1000000007 2)