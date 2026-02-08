(define/contract (separate-squares nums)
  (-> (listof exact-integer?) (listof exact-integer?))
  (let loop ([nums nums] [squares '()] [non-squares '()])
    (cond
      [(null? nums) (append (reverse squares) (reverse non-squares))]
      [(integer? (sqrt (car nums)))
       (loop (cdr nums) (cons (car nums) squares) non-squares)]
      [else
       (loop (cdr nums) squares (cons (car nums) non-squares))])))