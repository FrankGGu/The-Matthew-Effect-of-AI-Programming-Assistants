(define (fractionToDecimal numerator denominator)
  (define (helper num den)
    (if (= num 0)
        "0"
        (let* ((sign (if (and (< num 0) (>= den 0)) "-" (if (and (>= num 0) (< den 0)) "-" "")))
               (num (abs num))
               (den (abs den))
               (integer-part (quotient num den))
               (remainder (modulo num den))
               (result (string-append sign (number->string integer-part))))
          (if (= remainder 0)
              result
              (let loop ((rem remainder) (index 0) (map (make-hash) '()) (decimal ""))
                (if (zero? rem)
                    (string-append result decimal)
                    (let ((pos (hash-ref map rem #f)))
                      (if pos
                          (string-append result (substring decimal 0 pos) "(" decimal ")")
                          (begin
                            (hash-set! map rem index)
                            (loop (modulo (* rem 10) den) (+ index 1) map (string-append decimal (number->string (quotient (* rem 10) den)))))))))))))
  (helper numerator denominator))