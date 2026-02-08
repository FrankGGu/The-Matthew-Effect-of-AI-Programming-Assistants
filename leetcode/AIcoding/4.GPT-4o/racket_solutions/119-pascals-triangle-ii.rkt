(define (getRow rowIndex)
  (define (generate-row n)
    (if (= n 0)
        '(1)
        (let ([prev (generate-row (- n 1))])
          (cons 1
                (map + prev (append prev '(0))))))
    )
  (generate-row rowIndex))