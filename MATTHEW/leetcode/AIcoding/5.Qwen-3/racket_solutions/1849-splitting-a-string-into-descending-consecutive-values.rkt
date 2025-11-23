(define (split-string s)
  (define (helper start prev)
    (cond [(= start (string-length s)) #t]
          [else
           (let loop ([i (add1 start)])
             (if (<= i (string-length s))
                 (let ([current (string->number (substring s start i))])
                   (if (and current (>= prev current))
                       (or (helper i current) (loop (add1 i)))
                       #f))
                 #f))]))
  (let loop ([i 1])
    (if (<= i (string-length s))
        (let ([first (string->number (substring s 0 i))])
          (if first
              (if (= i (string-length s)) #f (helper i first))
              (loop (add1 i))))
        #f)))