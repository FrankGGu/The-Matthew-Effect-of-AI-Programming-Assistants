(define (find-kth-number m n k)
  (define (count-less-equal mid)
    (let loop ([i 1] [count 0])
      (if (> i m)
          count
          (loop (+ i 1) (+ count (min (quotient mid i) n))))))

  (let loop ([low 1] [high (* m n)])
    (if (<= low high)
        (let ([mid (quotient (+ low high) 2)])
          (let ([count (count-less-equal mid)])
            (cond
              [(< count k) (loop (+ mid 1) high)]
              [(= count k) (if (>= (count-less-equal (- mid 1)) k)
                                 (loop low (- mid 1))
                                 mid)]
              [else (loop low (- mid 1))]))))
        low)))