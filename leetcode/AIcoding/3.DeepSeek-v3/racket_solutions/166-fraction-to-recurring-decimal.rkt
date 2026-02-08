(define/contract (fraction-to-recurring-decimal numerator denominator)
  (-> exact-integer? exact-integer? string?)
  (if (zero? numerator) "0"
      (let* ([sign (if (xor (< numerator 0) (< denominator 0)) "-" "")]
             [numerator (abs numerator)]
             [denominator (abs denominator)]
             [int-part (quotient numerator denominator)]
             [remainder (remainder numerator denominator)])
        (if (zero? remainder)
            (string-append sign (number->string int-part))
            (let loop ([remainder (* remainder 10)]
                       [decimal-parts '()]
                       [remainders '()]
                       [pos 0])
              (let ([quotient (quotient remainder denominator)]
                    [new-remainder (remainder remainder denominator)])
                (cond
                  [(zero? new-remainder)
                   (string-append sign (number->string int-part) "."
                   (list->string (reverse (cons (integer->char (+ quotient 48)) decimal-parts)))]
                  [(member remainder remainders)
                   (let ([idx (index-of remainders remainder)])
                     (string-append sign (number->string int-part) "."
                     (list->string (reverse (sub-list decimal-parts 0 idx)))
                     "(" (list->string (reverse (sub-list decimal-parts idx (length decimal-parts)))) ")")]
                  [else
                   (loop (* new-remainder 10)
                         (cons (integer->char (+ quotient 48)) decimal-parts)
                         (cons remainder remainders)
                         (+ pos 1))])))))))