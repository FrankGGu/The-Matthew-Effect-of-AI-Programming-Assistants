(define (convert-to-base-7 num)
  (if (= num 0)
      "0"
      (let loop ((n (if (< num 0) (- num) num))
                 (result ""))
        (if (= n 0)
            (if (< num 0) (string-append "-" (reverse result)) (reverse result))
            (loop (quotient n 7) (string-append result (number->string (modulo n 7))))))))