(define (palindrome-number? x)
  (if (< x 0)
      #f
      (let* ([s (number->string x)]
             [len (string-length s)])
        (let loop ([i 0])
          (cond
            [(>= i (/ len 2)) #t]
            [else (if (char=? (string-ref s i) (string-ref s (- len i 1)))
                      (loop (+ i 1))
                      #f)])))))