(define (countGoodIntegers low high k)
  (define (good? n)
    (let loop ((num n) (last-digit -1) (count 0))
      (if (zero? num)
          (>= count k)
          (let ((digit (modulo num 10)))
            (if (= digit last-digit)
                (loop (quotient num 10) last-digit (+ count 1))
                (loop (quotient num 10) digit 1))))))

  (define (count-in-range low high)
    (count (filter good? (range low (+ high 1)))))

  (count-in-range low high))

(define (range start end)
  (if (>= start end)
      '()
      (cons start (range (+ start 1) end))))

(countGoodIntegers 1 100 2) ; Example call