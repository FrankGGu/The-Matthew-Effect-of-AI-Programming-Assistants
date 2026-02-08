(define (abbreviate-product left right)
  (define (product l r)
    (if (> l r)
        1
        (* l (product (+ l 1) r))))

  (define prod (product left right))
  (define s (number->string prod))
  (define len (string-length s))

  (if (< len 11)
      s
      (let* ([first-five (substring s 0 5)]
             [last-five (substring s (- len 5) len)]
             [exponent (expt 10 (- len 10))]
             [trailing-zeros (let loop ([n prod] [count 0])
                                (if (zero? (modulo n 10))
                                    (loop (quotient n 10) (+ count 1))
                                    count))])
        (string-append first-five "..." last-five "e" (number->string trailing-zeros)))))