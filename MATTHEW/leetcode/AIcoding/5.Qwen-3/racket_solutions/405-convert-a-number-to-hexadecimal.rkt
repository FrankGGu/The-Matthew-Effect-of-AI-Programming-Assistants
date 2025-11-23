(define (to-hex num)
  (if (equal? num 0)
      "0"
      (let loop ((n (abs num)) (result '()))
        (if (= n 0)
            (list->string (reverse result))
            (loop (quotient n 16)
                  (cons (string-ref "0123456789abcdef" (modulo n 16)) result)))))