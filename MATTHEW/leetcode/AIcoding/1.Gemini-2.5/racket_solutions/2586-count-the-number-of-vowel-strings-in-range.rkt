(define (vowel-strings words left right)
  (define (is-vowel? c)
    (or (char=? c #\a)
        (char=? c #\e)
        (char=? c #\i)
        (char=? c #\o)
        (char=? c #\u)))

  (define (is-vowel-string? s)
    (and (is-vowel? (string-ref s 0))
         (is-vowel? (string-ref s (- (string-length s) 1)))))

  (for/sum ([i (in-range left (+ right 1))]
            #:when (is-vowel-string? (list-ref words i)))
    1))