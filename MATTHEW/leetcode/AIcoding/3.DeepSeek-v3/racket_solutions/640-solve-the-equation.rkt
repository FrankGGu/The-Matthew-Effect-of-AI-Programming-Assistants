(define (solve-equation equation)
  (let* ([parts (string-split equation "=")]
         [left (car parts)]
         [right (cadr parts)]
         [left-coeff (parse-expr left)]
         [right-coeff (parse-expr right)]
         [x-coeff (- (car left-coeff) (car right-coeff))]
         [const (- (cdr right-coeff) (cdr left-coeff))])
    (cond
      [(and (zero? x-coeff) (zero? const)) "Infinite solutions"]
      [(zero? x-coeff) "No solution"]
      [else (format "x=~a" (quotient const x-coeff))])))

(define (parse-expr s)
  (let ([tokens (regexp-match* #px"([+-]?\\d*x)|([+-]?\\d+)" s)]
        [x-coeff 0]
        [const 0])
    (for ([token (in-list tokens)])
      (cond
        [(string-contains? token "x")
         (let* ([num-str (string-replace token "x" "")]
                [num (if (or (string=? num-str "+") (string=? num-str ""))
                         1
                         (if (string=? num-str "-")
                             -1
                             (string->number num-str)))])
           (set! x-coeff (+ x-coeff num)))]
        [else
         (set! const (+ const (string->number token)))]))
    (cons x-coeff const)))