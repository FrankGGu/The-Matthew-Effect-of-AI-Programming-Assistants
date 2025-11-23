(define (isNumber s)
  (define (isDigit c)
    (and (char? c) (char<=? #\0 c #\9)))

  (define (isSign c)
    (or (char=? c #\+) (char=? c #\-)))

  (define (isExponent c)
    (char=? c #e))

  (define (checkInteger s start end)
    (if (>= start end)
        (false)
        (let loop ((i start) (hasDigit #f))
          (cond
            ((>= i end) hasDigit)
            ((isDigit (string-ref s i))
             (loop (+ i 1) #t))
            ((and (isSign (string-ref s i)) (zero? i))
             (loop (+ i 1) hasDigit))
            (else
             (if hasDigit
                 (loop (+ i 1) hasDigit)
                 #f))))))

  (define (checkFraction s start end)
    (if (>= start end)
        #f
        (let loop ((i start) (hasDigit #f))
          (cond
            ((>= i end) hasDigit)
            ((isDigit (string-ref s i))
             (loop (+ i 1) #t))
            ((char=? (string-ref s i) #\.)
             (loop (+ i 1) hasDigit))
            (else
             (if hasDigit
                 (loop (+ i 1) hasDigit)
                 #f))))))

  (define (checkExponent s start end)
    (if (>= start end)
        #f
        (let loop ((i start) (hasDigit #f))
          (cond
            ((>= i end) hasDigit)
            ((isExponent (string-ref s i))
             (if (and (>= (+ i 1) end)
                      (not hasDigit))
                 #f
                 (loop (+ i 1) hasDigit)))
            ((isSign (string-ref s i))
             (loop (+ i 1) hasDigit))
            (else
             (if (isDigit (string-ref s i))
                 (loop (+ i 1) #t)
                 #f))))))

  (define trimmed (string-trim s))
  (define len (string-length trimmed))
  (or (checkInteger trimmed 0 len)
      (checkFraction trimmed 0 len)
      (and (checkInteger trimmed 0 len)
           (checkExponent trimmed (+ (string-length trimmed) 1) len))))