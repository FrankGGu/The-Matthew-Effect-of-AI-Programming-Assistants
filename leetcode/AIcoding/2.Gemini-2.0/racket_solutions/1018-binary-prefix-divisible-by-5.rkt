(define (prefixes-div-by-5 A)
  (let loop ([A A] [num 0] [result '()])
    (cond
      [(empty? A) (reverse result)]
      [else
       (let* ([digit (car A)]
              [new-num (modulo (+ (* num 2) digit) 5)])
         (loop (cdr A) new-num (cons (zero? new-num) result)))])))