(define (fraction-addition expression)
  (let* ([len (string-length expression)]
         [i (box 0)] ; current index in expression
         [total-num 0]
         [total-den 1])

    (define (parse-number)
      (let ([start-idx (unbox i)])
        (while (and (< (unbox i) len) (char-numeric? (string-ref expression (unbox i))))
          (set-box! i (+ (unbox i) 1)))
        (string->number (substring expression start-idx (unbox i)))))

    (while (< (unbox i) len)
      (let* ([current-sign (if (char=? (string-ref expression (unbox i)) #\-) -1 1)]
             [_ (when (or (char=? (string-ref expression (unbox i)) #\+)
                          (char=? (string-ref expression (unbox i)) #\-))
                  (set-box! i (+ (unbox i) 1)))) ; consume sign if present
             [num (parse-number)]
             [_ (set-box! i (+ (unbox i) 1))] ; consume '/'
             [den (parse-number)])

        (let* ([new-num (+ (* total-num den) (* current-sign num total-den))]
               [new-den (* total-den den)]
               [common-divisor (gcd new-num new-den)])
          (set! total-num (/ new-num common-divisor))
          (set! total-den (/ new-den common-divisor)))))

    (if (zero? total-num)
        "0/1"
        (string-append (number->string total-num) "/" (number->string total-den)))))