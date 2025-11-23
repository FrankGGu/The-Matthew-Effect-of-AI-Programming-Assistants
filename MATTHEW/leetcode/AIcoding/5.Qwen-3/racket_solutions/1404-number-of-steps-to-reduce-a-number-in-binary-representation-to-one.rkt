(define (num-steps-to-reduce-to-one binary)
  (define (count-steps s)
    (if (= (string-length s) 1)
        0
        (+ (if (char=? (string-ref s 0) #\1) 1 0)
           (count-steps (substring s 1 (string-length s))))))
  (define (binary->decimal s)
    (if (= (string-length s) 0)
        0
        (+ (* (expt 2 (sub1 (string-length s))) (- (char->integer (string-ref s 0)) 48))
           (binary->decimal (substring s 1 (string-length s))))))
  (define (decimal->binary n)
    (if (= n 0)
        ""
        (string-append (decimal->binary (quotient n 2)) (number->string (remainder n 2)))))
  (define (steps n)
    (if (= n 1)
        0
        (+ (if (odd? n) 1 0)
           (steps (quotient n 2)))))
  (steps (binary->decimal binary)))