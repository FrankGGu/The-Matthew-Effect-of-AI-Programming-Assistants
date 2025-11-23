(define (total-characters-in-string-after-transformations s)
  (let loop ([str s] [count 0])
    (if (string=? str "")
        count
        (let ([n (string-length str)])
          (cond
            [(= n 1) (+ count 1)]
            [(and (> n 1) (char=? (string-ref str 0) (string-ref str 1)))
             (loop (substring str 2 n) (+ count 1))]
            [else (loop (substring str 1 n) (+ count 1))])))))