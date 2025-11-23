(define (greatest-letter s)
  (define upper-chars (make-hash))
  (define lower-chars (make-hash))

  (for ([c (string->list s)])
    (if (char-upper-case? c)
        (hash-set! upper-chars c #t)
        (hash-set! lower-chars c #t)))

  (for/last ([c (in-range (char->integer #\Z) (char->integer #\A) -1)]
             #:when (and (hash-ref upper-chars (integer->char c) #f)
                         (hash-ref lower-chars (integer->char (+ 32 c)) #f))
             (integer->char c)))