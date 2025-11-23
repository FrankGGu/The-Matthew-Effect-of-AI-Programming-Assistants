(define (calculate s)
  (let* ([len (string-length s)]
         [nums '()]
         [current-num 0]
         [last-op #\+])

    (for ([i (in-range len)])
      (let ([char (string-ref s i)])
        (cond
          [(char-numeric? char)
           (set! current-num (+ (* current-num 10) (- (char->integer char) (char->integer #\0))))]

          [(char-whitespace? char)
           ]

          [else
           (case last-op
             [#\+] (set! nums (cons current-num nums))
             [#\-] (set! nums (cons (- current-num) nums))
             [#\*] (set! nums (cons (* (car nums) current-num) (cdr nums)))
             [#\/] (set! nums (cons (quotient (car nums) current-num) (cdr nums))))
           (set! last-op char)
           (set! current-num 0)])))

    (case last-op
      [#\+] (set! nums (cons current-num nums))
      [#\-] (set! nums (cons (- current-num) nums))
      [#\*] (set! nums (cons (* (car nums) current-num) (cdr nums)))
      [#\/] (set! nums (cons (quotient (car nums) current-num) (cdr nums))))

    (apply + nums)))