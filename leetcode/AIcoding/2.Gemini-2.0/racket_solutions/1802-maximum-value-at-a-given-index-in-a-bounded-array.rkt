(define (max-value-after-incrementing n index maxSum)
  (define (check-valid mid)
    (let* ([left (min index mid)]
           [right (min (- n index 1) mid)]
           [left-sum (if (> mid index) (+ mid (+ mid (- index) 1) (* (- index 1) 1/2)) (+ mid (* (/ (+ mid 1) 2) index)))]
           [right-sum (if (> mid (- n index 1)) (+ mid (+ mid (- (- n index 1) 1) 1) (* (- (- n index 1) 1) 1/2)) (+ mid (* (/ (+ mid 1) 2) (- n index 1))))]
           [total (+ left-sum right-sum (- mid))])
      (if (<= total (- maxSum n)) #t #f)))

  (let loop ([low 1] [high maxSum])
    (if (<= low high)
        (let ([mid (floor (/ (+ low high) 2))])
          (if (check-valid mid)
              (loop (+ mid 1) high)
              (loop low (- mid 1))))
        (- low 1))))