(define (guessNumber n)
  (define (guess x)
    (cond
      ((< x (guess-number)) -1)
      ((> x (guess-number)) 1)
      (else 0)))

  (define (binary-search low high)
    (if (<= low high)
      (let ((mid (quotient (+ low high) 2)))
        (cond
          ((= (guess mid) 0) mid)
          ((< (guess mid) 0) (binary-search low (- mid 1)))
          (else (binary-search (+ mid 1) high))))
      -1))

  (binary-search 1 n))