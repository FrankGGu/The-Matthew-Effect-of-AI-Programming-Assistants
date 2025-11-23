(define (sum-of-number-and-reverse num)
  (define (reverse x)
    (let loop ((n x) (acc 0))
      (if (zero? n)
          acc
          (loop (quotient n 10) (+ (* acc 10) (remainder n 10))))))

  (let loop ((i 0))
    (cond
      [(> i num) #f]
      [(= (+ i (reverse i)) num) #t]
      [else (loop (+ i 1))])))