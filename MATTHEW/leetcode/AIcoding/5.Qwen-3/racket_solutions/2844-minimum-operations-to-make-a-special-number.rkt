(define (minimum-operations s)
  (define (count-zeroes s)
    (let loop ([s s] [count 0])
      (if (null? s)
          count
          (loop (cdr s) (+ count (if (char=? (car s) #\0) 1 0))))))

  (define (min-ops s)
    (let loop ([i 0] [count 0])
      (if (= i (string-length s))
          count
          (let ([c (string-ref s i)])
            (if (char=? c #\0)
                (loop (+ i 1) count)
                (loop (+ i 1) (+ count 1)))))))

  (let ([zero-count (count-zeroes (string->list s))])
    (if (zero-count 0)
        (min-ops s)
        (let ([first-non-zero (let loop ([i 0])
                                (if (= i (string-length s))
                                    -1
                                    (if (char=? (string-ref s i) #\0)
                                        (loop (+ i 1))
                                        i)))])
          (if (= first-non-zero -1)
              0
              (let ([non-zero-count (let loop ([i first-non-zero] [count 0])
                                      (if (= i (string-length s))
                                          count
                                          (loop (+ i 1) (+ count 1)))))])
                (min (min-ops s) (- (string-length s) non-zero-count))))))))