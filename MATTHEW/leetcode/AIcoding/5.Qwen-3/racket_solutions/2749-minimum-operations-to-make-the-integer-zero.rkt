(define (minimum-operations num)
  (define (helper n)
    (if (= n 0)
        0
        (+ (remainder n 10)
           (helper (quotient n 10)))))
  (if (= num 0)
      0
      (let loop ((n num) (count 0))
        (if (= n 0)
            count
            (loop (quotient n 10) (+ count (remainder n 10)))))))