(define (guessNumber n)
  (define (guess x)
    ; This function mimics the guess API
    ; Replace with actual guessing logic based on the problem statement
    (cond
      ((< x target) -1)
      ((> x target) 1)
      (else 0)))

  (define (binary-search low high)
    (if (> low high)
        -1
        (let ((mid (quotient (+ low high) 2)))
          (case (guess mid)
            ((-1) (binary-search (+ mid 1) high))
            ((1) (binary-search low (- mid 1)))
            ((0) mid)))))

  (binary-search 1 n))