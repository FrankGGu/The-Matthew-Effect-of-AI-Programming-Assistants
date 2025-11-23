(define (generate-parenthesis n)
  (define (backtrack s left right)
    (if (= (string-length s) (* 2 n))
        (list s)
        (append
         (if (<= left (- n 1)) (backtrack (string-append s "(") (+ left 1) right) '())
         (if (<= right left) (backtrack (string-append s ")") left (+ right 1)) '()))))
  (backtrack "" 0 0))