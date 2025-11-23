(define (valid-number s)
  (let* ([trimmed-s (string-trim s)]
         [len (string-length trimmed-s)])
    (if (= len 0)
        #f
        (let loop ([i 0]
                   [has-digit #f]
                   [has-dot #f]
                   [has-e #f]
                   [has-digit-after-e #f]
                   [has-digit-after-dot #f])
          (if (= i len)
              (and has-digit (or (not has-e) has-digit-after-e))
              (let ([char (string-ref trimmed-s i)])
                (cond
                  [(char-numeric? char)
                   (loop (+ i 1)
                         #t
                         has-dot
                         has-e
                         (if has-e #t has-digit-after-e)
                         (if has-dot #t has-digit-after-dot))]
                  [(char-eqv? char #\.)
                   (if (or has-dot has-e)
                       #f
                       (loop (+ i 1) has-digit #t has-e has-digit-after-e #f))]
                  [(or (char-eqv? char #\e) (char-eqv? char #\E))
                   (if (or has-e
                           (not has-digit)
                           (and has-dot (not has-digit-after-dot)))
                       #f
                       (loop (+ i 1) has-digit has-dot #t #f has-digit-after-dot))]
                  [(or (char-eqv? char #\+) (char-eqv? char #\-))
                   (if (or (= i 0) (and has-e (or (char-eqv? (string-ref trimmed-s (- i 1)) #\e)
                                                  (char-eqv? (string-ref trimmed-s (- i 1)) #\E))))
                       (loop (+ i 1) has-digit has-dot has-e has-digit-after-e has-digit-after-dot)
                       #f)]
                  [else
                   #f])))))))