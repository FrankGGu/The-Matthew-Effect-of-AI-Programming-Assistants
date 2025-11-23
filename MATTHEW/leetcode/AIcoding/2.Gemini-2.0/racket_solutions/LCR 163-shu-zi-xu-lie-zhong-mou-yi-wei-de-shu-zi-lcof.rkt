(define (find-nth-digit n)
  (let loop ([digits 1] [count 9] [start 1])
    (cond
      [(= n< count)
       (let* ([num (+ start (quotient (- n 1) digits))]
              [digit-index (remainder (- n 1) digits)])
         (string->number (substring (number->string num) digit-index (+ digit-index 1)))))
      [else
       (loop (+ digits 1) (* count 10) (* start 10))])))