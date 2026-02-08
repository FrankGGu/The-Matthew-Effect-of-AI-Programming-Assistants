(define (count-digits num)
  (let loop ([n num] [count 0])
    (if (zero? n)
        count
        (let ([digit (remainder n 10)])
          (if (and (not (zero? digit)) (zero? (remainder num digit)))
              (loop (quotient n 10) (+ count 1))
              (loop (quotient n 10) count))))))