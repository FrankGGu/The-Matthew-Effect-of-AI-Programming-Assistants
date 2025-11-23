(define (max-special-substrings s k)
  (define n (string-length s))
  (define (is-special? sub)
    (and (not (string=? sub ""))
         (let loop ([i 0])
           (cond [(>= i (string-length sub)) #t]
                 [(char=? (string-ref sub i) #\0) #f]
                 [else (loop (+ i 1))]))))

  (define (solve i count last-end)
    (cond [(>= i n) count]
          [else
           (let* ([skip (solve (+ i 1) count last-end)]
                  [take (let loop ([j i])
                          (cond [(>= j n) 0]
                                [else
                                 (let ([sub (substring s i (+ j 1))])
                                   (if (and (is-special? sub)
                                            (or (equal? last-end -1)
                                                (>= i (+ last-end 1))))
                                       (solve (+ j 1) (+ count 1) j)
                                       (loop (+ j 1))))))])
             (max skip take))]))

  (solve 0 0 -1))