(define (numDecodings s)
  (let ([n (string-length s)])
    (if (zero? n) 0
        (let loop ([i 0] [prev1 1] [prev2 0])
          (if (= i n) prev1
              (let* ([current (if (char=? (string-ref s i) #\0) 0 1)]
                     [two-digit (if (and (> i 0) 
                                         (or (char=? (string-ref s (- i 1)) #\1) 
                                             (and (char=? (string-ref s (- i 1)) #\2) 
                                                  (char<=? (string-ref s i) #\6)))))
                                   1 0)]
                     [new-prev1 (+ (* current prev1) (* two-digit prev2))])
                (loop (+ i 1) new-prev1 prev1)))))))