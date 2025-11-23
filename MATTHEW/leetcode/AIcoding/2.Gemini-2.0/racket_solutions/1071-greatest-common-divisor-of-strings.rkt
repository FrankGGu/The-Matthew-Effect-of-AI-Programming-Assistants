(define (gcd-strings str1 str2)
  (define (divides s t)
    (if (string=? "" t)
        #t
        (if (string-prefix? s t)
            (divides s (substring t (string-length s)))
            #f)))

  (define (find-gcd s t)
    (if (string=? s t)
        s
        (if (> (string-length s) (string-length t))
            (find-gcd (substring s (string-length t)) t)
            (find-gcd (substring t (string-length s)) s))))

  (define gcd (find-gcd str1 str2))
  (if (and (divides gcd str1) (divides gcd str2))
      gcd
      ""))