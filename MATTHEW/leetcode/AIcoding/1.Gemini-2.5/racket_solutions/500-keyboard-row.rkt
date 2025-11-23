(define (find-words words)
  (define row1 (set #\q #\w #\e #\r #\t #\y #\u #\i #\o #\p))
  (define row2 (set #\a #\s #\d #\f #\g #\h #\j #\k #\l))
  (define row3 (set #\z #\x #\c #\v #\b #\n #\m))

  (define (word-in-single-row? word)
    (define lower-chars (map char-downcase (string->list word)))

    (define (check-row chars current-row)
      (if (empty? chars)
          #t
          (and (set-member? current-row (car chars))
               (check-row (cdr chars) current-row))))

    (or (check-row lower-chars row1)
        (check-row lower-chars row2)
        (check-row lower-chars row3)))

  (filter word-in-single-row? words))