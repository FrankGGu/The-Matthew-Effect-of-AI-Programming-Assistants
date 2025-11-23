(define (min-changes s)
  (let ([n (string-length s)])
    (let loop ([i 0] [changes 0])
      (if (>= i n)
          changes
          (let ([first (string-ref s i)]
                [second (string-ref s (+ i 1))])
            (if (equal? first second)
                (loop (+ i 2) changes)
                (loop (+ i 2) (+ changes 1))))))))