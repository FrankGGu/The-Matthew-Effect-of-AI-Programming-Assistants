(define/contract (strong-password-checker-ii password)
  (-> string? boolean?)
  (let ([n (string-length password)])
    (if (< n 8)
        #f
        (let ([has-lower #f]
              [has-upper #f]
              [has-digit #f]
              [has-special #f]
              [no-repeat #t])
          (for ([i (in-range n)])
            (let ([c (string-ref password i)])
              (when (char-lower-case? c) (set! has-lower #t))
              (when (char-upper-case? c) (set! has-upper #t))
              (when (char-numeric? c) (set! has-digit #t))
              (when (string-contains? "!@#$%^&*()-+" (string c)) (set! has-special #t))
              (when (and (> i 0) (char=? (string-ref password (- i 1)) c)) (set! no-repeat #f))))
          (and has-lower has-upper has-digit has-special no-repeat)))))