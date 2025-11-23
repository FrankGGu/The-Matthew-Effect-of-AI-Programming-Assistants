(define (check-if-pangram sentence)
  (define alphabet (string->list "abcdefghijklmnopqrstuvwxyz"))
  (define sentence-chars (remove (lambda (c) (char=? c #\space)) (string->list sentence)))
  (define unique-chars (remove-duplicates sentence-chars))
  (define char-set (set unique-chars))
  (define alphabet-set (set alphabet))
  (set-superset? char-set alphabet-set))

(check-if-pangram "the quick brown fox jumps over the lazy dog")