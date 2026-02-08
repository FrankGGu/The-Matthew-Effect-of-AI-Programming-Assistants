(define (generate-parentheses n)
  (define (backtrack left right current)
    (if (= (string-length current) (* 2 n))
        (list current)
        (append 
          (if (< left n) (backtrack (+ left 1) right (string-append current "(")) '()) 
          (if (< right left) (backtrack left (+ right 1) (string-append current ")")) '()))))
  (backtrack 0 0 ""))

(define (generateParenthesis n)
  (generate-parentheses n))