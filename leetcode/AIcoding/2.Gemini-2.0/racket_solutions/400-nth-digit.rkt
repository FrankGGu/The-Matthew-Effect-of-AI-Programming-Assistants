(define (find-nth-digit n)
  (let loop ([digits 1] [count 9])
    (if (> n (* digits count))
        (loop (+ 1 digits) (* 10 count))
        (let* ([start (expt 10 (- digits 1))]
               [offset (- n 1)]
               [number (+ start (quotient offset digits))]
               [digit-index (remainder offset digits)])
          (string->number (substring (number->string number) digit-index (+ 1 digit-index)))))))