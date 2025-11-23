(define (encrypt-string s)
  (let loop ([s s] [result ""])
    (if (string=? s "")
        result
        (let* ([n (string-length s)]
               [mid (quotient (sub1 n) 2)]
               [c (substring s mid (add1 mid))])
          (loop (string-append (substring s 0 mid) (substring s (add1 mid) n))
                (string-append result c))))))