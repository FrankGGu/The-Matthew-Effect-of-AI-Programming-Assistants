(define (largestMultipleOfThree digits)
  (define sorted-digits (sort digits >))
  (define (is-valid num)
    (and (not (zero? (length num)))
         (zero? (modulo (foldl + 0 (map (lambda (d) (string->number (string d))) num)) 3))))
  (define (backtrack num)
    (if (is-valid num)
        (apply string-append (map (lambda (d) (number->string d)) num))
        (if (null? num)
            ""
            (let ((result (backtrack (cdr num))))
              (if (not (string=? result ""))
                  result
                  (backtrack (cdr (cdr num))))))))
  (let ((result (backtrack sorted-digits)))
    (if (string=? result "")
        "0"
        result)))

(largestMultipleOfThree '(8 1 9))