(define (find-nth-digit n)
  (let loop ([digits 1] [count 9] [start 1] [remaining n])
    (if (> (* digits count) remaining)
        (let* ([num (+ start (quotient (sub1 remaining) digits))]
               [digit-pos (remainder (sub1 remaining) digits)]
               [digit (string-ref (number->string num) digit-pos)])
          (- (char->integer digit) 48))
        (loop (add1 digits) (* 10 count) (* 10 start) (- remaining (* digits count))))))