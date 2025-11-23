(define (minimumElementAfterReplacement nums)
  (define (digit-sum n)
    (if (= n 0)
        0
        (+ (modulo n 10) (digit-sum (quotient n 10)))))

  (define (replace num)
    (let loop ((x num))
      (if (< x 10)
          x
          (loop (digit-sum x)))))

  (define min-replaced (map replace nums))
  (apply min min-replaced))

(minimumElementAfterReplacement '(3 2 1 4))