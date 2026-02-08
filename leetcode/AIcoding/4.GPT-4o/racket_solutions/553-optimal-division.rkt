(define (optimalDivision nums)
  (if (null? nums)
      ""
      (let* ((n (length nums)))
        (if (= n 1)
            (number->string (car nums))
            (if (= n 2)
                (string-append (number->string (car nums)) "/" (number->string (cadr nums)))
                (string-append (number->string (car nums)) "/(" (string-join (map number->string (cdr nums)) "/") ")"))))))