(define/contract (is-valid word)
  (-> string? boolean?)
  (let ([vowels (set #\a #\e #\i #\o #\u #\A #\E #\I #\O #\U)]
        [consonants (set #\b #\c #\d #\f #\g #\h #\j #\k #\l #\m #\n #\p #\q #\r #\s #\t #\v #\w #\x #\y #\z
                         #\B #\C #\D #\F #\G #\H #\J #\K #\L #\M #\N #\P #\Q #\R #\S #\T #\V #\W #\X #\Y #\Z)])
    (and (>= (string-length word) 3)
         (let loop ([chars (string->list word)])
           (if (null? chars)
               #t
               (let ([c (car chars)])
                 (and (or (set-member? vowels c)
                          (set-member? consonants c)
                          (char-numeric? c))
                      (loop (cdr chars)))))))))