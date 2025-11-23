(define (readBinaryWatch num)
  (define (count-set-bits n)
    (if (= n 0) 0 (+ (modulo n 2) (count-set-bits (quotient n 2)))))

  (define (generate-times num)
    (for*/list ([h (in-range 0 12)]
                 [m (in-range 0 60)]
                 #:when (= (+ (count-set-bits h) (count-set-bits m)) num))
      (string-append (number->string h) ":" (format "~2d" m))))

  (generate-times num))