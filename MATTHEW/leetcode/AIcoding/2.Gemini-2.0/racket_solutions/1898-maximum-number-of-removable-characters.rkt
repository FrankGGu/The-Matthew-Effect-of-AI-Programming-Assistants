(define (maximum-removable-characters s p removable)
  (define (is-subsequence t u)
    (let loop ([i 0] [j 0])
      (cond [(>= j (string-length u)) #t]
            [(>= i (string-length t)) #f]
            [(char=? (string-ref t i) (string-ref u j)) (loop (+ 1 i) (+ 1 j))]
            [else (loop (+ 1 i) j)])))

  (define (check k)
    (let ([removed-indices (take removable k)])
      (let ([modified-s (string-copy s)])
        (for ([index removed-indices])
          (string-set! modified-s index #\space))
        (let ([filtered-s (string-filter (lambda (c) (not (char=? c #\space))) modified-s)])
          (is-subsequence filtered-s p)))))

  (let loop ([low 0] [high (length removable)])
    (cond [(> low high) (- low 1)]
          [else
           (let ([mid (floor (/ (+ low high) 2))])
             (if (check mid)
                 (loop (+ mid 1) high)
                 (loop low (- mid 1))))])))