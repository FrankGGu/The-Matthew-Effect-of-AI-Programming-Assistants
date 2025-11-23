(define (generate-parenthesis n)
  (define (backtrack open close current res)
    (cond
      [(= (string-length current) (* 2 n)) (cons current res)]
      [(< open n) (backtrack (+ open 1) close (string-append current "(") res)]
      [(< close open) (backtrack open (+ close 1) (string-append current ")") res)]
      [else res]))
  (backtrack 0 0 "" '()))