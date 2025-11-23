(define (alternating-digit-sum n)
  (let* ([s (number->string n)]
         [len (string-length s)])
    (for/sum ([i (in-range len)])
      (let* ([char-digit (string-ref s i)]
             [digit (- (char->integer char-digit) (char->integer #\0))])
        (if (even? i)
            digit
            (- digit))))))