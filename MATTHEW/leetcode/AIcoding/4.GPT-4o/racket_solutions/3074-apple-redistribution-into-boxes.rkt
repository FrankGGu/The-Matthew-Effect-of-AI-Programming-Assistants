(define (min-boxes apples)
  (define (count-boxes n)
    (if (zero? n) 0
        (let ((boxes (quotient n 100)))
          (+ boxes (count-boxes (remainder n 100))))))
  (count-boxes apples))

(min-boxes 1000)