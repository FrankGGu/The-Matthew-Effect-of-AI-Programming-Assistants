(define (greatestLetter s)
  (define letters (string->list s))
  (define lower (make-hash))
  (define upper (make-hash))

  (for-each (lambda (c)
              (if (and (char? c) (char<=? #\a c #\z))
                  (hash-set! lower c #t)
                  (if (and (char? c) (char<=? #\A c #\Z))
                      (hash-set! upper c #t))))
            letters)

  (define result #\0)
  (for-each (lambda (c)
              (when (hash-ref upper (char-upcase c) #f)
                (when (hash-ref lower c #f)
                  (if (> (char->integer c) (char->integer result))
                      (set! result c)))))
            (hash-keys lower))

  (if (char=? result #\0)
      ""
      (string (char-upcase result))))