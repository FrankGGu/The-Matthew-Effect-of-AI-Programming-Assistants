(define (int->roman num)
  (define values '(1000 900 500 400 100 90 50 40 10 9 5 4 1))
  (define numerals '("M" "CM" "D" "CD" "C" "XC" "L" "XL" "X" "IX" "V" "IV" "I"))
  (define (helper n values numerals acc)
    (cond
      [(zero? n) acc]
      [else
       (let* ([value (car values)]
              [numeral (car numerals)]
              [times (floor (/ n value))])
         (helper (- n (* times value)) (cdr values) (cdr numerals) (string-append acc (make-string times numeral))))]))
  (helper num values numerals ""))