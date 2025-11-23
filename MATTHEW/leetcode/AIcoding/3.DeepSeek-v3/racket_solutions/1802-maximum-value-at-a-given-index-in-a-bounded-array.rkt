(define (max-value n index max-sum)
  (define (sum x m)
    (cond
      [(<= x m) (quotient (* x (+ x 1)) 2)]
      [else (let ([diff (- x m)])
              (+ (quotient (* m (+ m 1)) 2) (* diff m)))]))

  (define (calc l r m)
    (+ (sum (- m 1) l) (sum (- m 1) r) m))

  (let loop ([left 1] [right max-sum])
    (if (> left right)
        left
        (let* ([mid (quotient (+ left right) 2)]
               [l (min index (- mid 1))]
               [r (min (- n index 1) (- mid 1))]
               [total (+ l r 1)]
               [s (calc l r mid)])
          (cond
            [(and (<= s max-sum) (<= total n)) (loop (+ mid 1) right)]
            [else (loop left (- mid 1))]))))