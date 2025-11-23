(define (find-words words)
  (define row1 (set #\q #\w #\e #\r #\t #\y #\u #\i #\o #\p))
  (define row2 (set #\a #\s #\d #\f #\g #\h #\j #\k #\l))
  (define row3 (set #\z #\x #\c #\v #\b #\n #\m))

  (define (in-row? word row)
    (for/and ([c (string->list word)])
      (set-member? row (char-downcase c))))

  (define (check-word word)
    (or (in-row? word row1)
        (in-row? word row2)
        (in-row? word row3)))

  (filter check-word words))