(define (digit-count s)
  (let loop ([i 0] [count 0])
    (if (>= i (string-length s))
        count
        (if (char-numeric? (string-ref s i))
            (loop (+ i 1) (+ count 1))
            (loop (+ i 1) count)))))

(define (check-digits s)
  (let ([n (string-length s)]
        [digits (digit-count s)])
    (if (zero? digits)
        #t
        (let ([first-digit (let loop ([i 0])
                             (if (char-numeric? (string-ref s i))
                                 (string-ref s i)
                                 (loop (+ i 1))))]
              [last-digit (let loop ([i (- n 1)])
                            (if (char-numeric? (string-ref s i))
                                (string-ref s i)
                                (loop (- i 1))))])
          (char=? first-digit last-digit)))))

(define (check-if-equal-after-operations s)
  (check-digits s))