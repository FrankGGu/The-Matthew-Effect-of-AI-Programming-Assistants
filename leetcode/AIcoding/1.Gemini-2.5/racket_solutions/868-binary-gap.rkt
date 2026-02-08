(define (binary-gap n)
  (let* ([s (number->string n 2)]
         [len (string-length s)])
    (let loop ([i 0]
               [max-gap 0]
               [last-one-idx -1])
      (cond
        [(>= i len) max-gap]
        [(char=? (string-ref s i) #\1)
         (let ([current-gap (if (= last-one-idx -1)
                                0
                                (- i last-one-idx))])
           (loop (+ i 1)
                 (max max-gap current-gap)
                 i))]
        [else
         (loop (+ i 1) max-gap last-one-idx)]))))