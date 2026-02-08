(define (gcd a b)
  (if (= b 0) a (gcd b (remainder a b))))

(define (parse-rational s)
  (define (parse-integer-part s)
    (string->number s))

  (define (parse-fractional-part s)
    (let* ([dot-pos (string-index s #\. )]
           [integer-part (if dot-pos (substring s 0 dot-pos) s)]
           [fractional-part (if dot-pos (substring s (+ dot-pos 1) (string-length s)) "")])
      (values (parse-integer-part integer-part) fractional-part)))

  (define (parse-recurring-part s)
    (let* ([open-paren-pos (string-index s #\()
           [close-paren-pos (string-index s #\))]
           [non-recurring-part (if open-paren-pos (substring s 0 open-paren-pos) s)]
           [recurring-part (if open-paren-pos (substring s (+ open-paren-pos 1) close-paren-pos) "")])
      (values non-recurring-part recurring-part)))

  (let-values ([(integer-part fractional-part) (parse-fractional-part s)])
    (let-values ([(non-recurring-part recurring-part) (parse-recurring-part fractional-part)])
      (let ([non-recurring-number (if (string=? non-recurring-part "") 0 (string->number non-recurring-part))]
            [recurring-number (if (string=? recurring-part "") 0 (string->number recurring-part))]
            [non-recurring-length (string-length non-recurring-part)]
            [recurring-length (string-length recurring-part)])

        (let ([numerator (+ (* integer-part (expt 10 (+ non-recurring-length recurring-length)))
                              (* non-recurring-number (expt 10 recurring-length))
                              recurring-number
                              (- (* integer-part (expt 10 non-recurring-length)))
                              (- non-recurring-number))])
          (let ([denominator (- (expt 10 (+ non-recurring-length recurring-length)) (expt 10 non-recurring-length))])
            (let ([g (gcd numerator denominator)])
              (cons (/ numerator g) (/ denominator g)))))))))

(define (equal-rational-numbers s t)
  (let* ([(num1 . den1) (parse-rational s)]
         [(num2 . den2) (parse-rational t)])
    (= (* num1 den2) (* num2 den1))))