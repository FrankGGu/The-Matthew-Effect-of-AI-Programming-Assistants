(define (maxFrequencyScore nums k)
  (define sorted-nums (sort nums <))
  (define n (length sorted-nums))
  (define (calculate-cost l r)
    (let ([mid (quotient (+ l r) 2)])
      (let loop ([i l] [cost 0])
        (cond
          [(> i r) cost]
          [else (loop (+ i 1) (+ cost (abs (- (list-ref sorted-nums i) (list-ref sorted-nums mid)))))]))))

  (define (check-valid l r)
    (<= (calculate-cost l r) k))

  (define (max-len l)
    (let loop ([r l] [max-len 0])
      (cond
        [(>= r n) max-len]
        [(check-valid l r) (loop (+ r 1) (+ 1 (- r l)))]
        [else max-len])))

  (let loop ([l 0] [max-freq 0])
    (cond
      [(>= l n) max-freq]
      [else (loop (+ l 1) (max max-freq (max-len l)))])))