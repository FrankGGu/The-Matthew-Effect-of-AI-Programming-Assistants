(define (longest-vowel-substring s)
  (define (vowel? c)
    (or (char=? c #\a)
        (char=? c #\e)
        (char=? c #\i)
        (char=? c #\o)
        (char=? c #\u)))

  (define (solve s current-vowel current-length max-length)
    (cond
      [(empty? s) max-length]
      [else
       (let* ([first-char (first s)]
              [rest-s (rest s)])
         (cond
           [(not (vowel? first-char))
            (solve rest-s #\a 0 max-length)]
           [(char=? first-char current-vowel)
            (let ([next-vowel
                    (cond
                      [(char=? current-vowel #\a) #\e]
                      [(char=? current-vowel #\e) #\i]
                      [(char=? current-vowel #\i) #\o]
                      [(char=? current-vowel #\o) #\u]
                      [else #\u])])
              (solve rest-s
                     next-vowel
                     (+ current-length 1)
                     (max max-length (+ current-length 1))))]
           [(and (char=? first-char #\a) (char=? current-vowel #\e))
            (solve rest-s #\e 0 max-length)]
           [(and (char=? first-char #\a) (char=? current-vowel #\i))
            (solve rest-s #\i 0 max-length)]
           [(and (char=? first-char #\a) (char=? current-vowel #\o))
            (solve rest-s #\o 0 max-length)]
           [(and (char=? first-char #\a) (char=? current-vowel #\u))
            (solve rest-s #\u 0 max-length)]

           [(and (char=? first-char #\e) (char=? current-vowel #\i))
            (solve rest-s #\i 0 max-length)]
           [(and (char=? first-char #\e) (char=? current-vowel #\o))
            (solve rest-s #\o 0 max-length)]
           [(and (char=? first-char #\e) (char=? current-vowel #\u))
            (solve rest-s #\u 0 max-length)]

           [(and (char=? first-char #\i) (char=? current-vowel #\o))
            (solve rest-s #\o 0 max-length)]
           [(and (char=? first-char #\i) (char=? current-vowel #\u))
            (solve rest-s #\u 0 max-length)]

           [(and (char=? first-char #\o) (char=? current-vowel #\u))
            (solve rest-s #\u 0 max-length)]
           [(char=? first-char #\a)
            (solve rest-s #\e 1 (max max-length 1))]
           [else (solve rest-s #\a 0 max-length)])))]))

  (solve (string->list s) #\a 0 0))