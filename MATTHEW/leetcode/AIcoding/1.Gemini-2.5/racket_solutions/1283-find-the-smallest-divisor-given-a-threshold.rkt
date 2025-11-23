(define (check nums threshold divisor)
  (let ((current-sum (apply + (map (lambda (num) (ceiling (/ num divisor))) nums))))
    (<= current-sum threshold)))

(define (find-smallest-divisor nums threshold)
  (let* ((max-num (apply max nums))
         (low 1)
         (high max-num)
         (ans max-num))

    (let loop ((low low) (high high) (ans ans))
      (if (> low high)
          ans
          (let* ((mid (+ low (quotient (- high low) 2))))
            (if (check nums threshold mid)
                (loop low (- mid 1) mid)
                (loop (+ mid 1) high ans)))))))