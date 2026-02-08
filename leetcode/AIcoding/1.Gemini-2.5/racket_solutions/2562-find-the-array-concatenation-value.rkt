(define (find-array-concatenation-value nums)
  (let* ([n (vector-length nums)]
         [left 0]
         [right (- n 1)])
    (let loop ([l left] [r right] [total 0])
      (cond
        [(> l r) total]
        [(= l r) (+ total (vector-ref nums l))]
        [else
         (let* ([num1 (vector-ref nums l)]
                [num2 (vector-ref nums r)]
                [s1 (number->string num1)]
                [s2 (number->string num2)]
                [concatenated-string (string-append s1 s2)]
                [concatenated-num (string->number concatenated-string)])
           (loop (+ l 1) (- r 1) (+ total concatenated-num)))]))))