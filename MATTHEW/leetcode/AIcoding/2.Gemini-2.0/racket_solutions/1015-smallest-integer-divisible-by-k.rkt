(define (smallestRepunitDivByK K)
  (if (equal? K 1)
      1
      (let loop ([rem 0] [len 0])
        (if (> len K)
            -1
            (let ([new-rem (modulo (+ (* rem 10) 1) K)])
              (if (equal? new-rem 0)
                  (+ len 1)
                  (loop new-rem (+ len 1))))))))