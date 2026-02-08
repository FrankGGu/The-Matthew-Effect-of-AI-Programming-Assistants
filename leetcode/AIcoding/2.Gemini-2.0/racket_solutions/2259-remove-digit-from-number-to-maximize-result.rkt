(define (remove-digit number digit)
  (let loop ([s (number->string number)]
             [i 0]
             [max-result ""])
    (cond
      [(= i (string-length s)) max-result]
      [(equal? (string (string-ref s i)) digit)
       (let ([new-s (string-append (substring s 0 i) (substring s (+ i 1) (string-length s)))])
         (if (string>? new-s max-result)
             (loop s (+ i 1) new-s)
             (loop s (+ i 1) max-result)))]
      [else (loop s (+ i 1) max-result)])))