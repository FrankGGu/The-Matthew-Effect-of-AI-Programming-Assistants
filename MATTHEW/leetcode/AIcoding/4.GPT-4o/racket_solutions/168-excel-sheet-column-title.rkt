(define (convertToTitle n)
  (define (helper n)
    (if (= n 0)
        ""
        (string-append (helper (sub1 (quotient (sub1 n) 26)))
                       (string (integer->char (+ (modulo (sub1 n) 26) (char->integer #\A))))))
    )
  (helper n)
)

(convertToTitle)