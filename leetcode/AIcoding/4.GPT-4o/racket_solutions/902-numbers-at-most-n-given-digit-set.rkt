(define (atMostNGivenDigitSet digits n)
  (define len (string-length (number->string n)))
  (define digit-count (length digits))
  (define result 0)

  (for ([i (in-range 1 len)])
    (set! result (+ result (expt digit-count i))))

  (define (count-valid-numbers prefix remaining)
    (if (zero? remaining)
        (if (string<=? prefix (number->string n)) 1 0)
        (foldl (lambda (d acc)
                  (+ acc (count-valid-numbers (string-append prefix d) (- remaining 1))))
                0
                digits)))

  (set! result (+ result (count-valid-numbers "" len)))
  result)