(define (detect-capital word)
  (define len (string-length word))

  (or
   (for/and ([c (in-string word)])
     (char-upper-case? c))

   (for/and ([c (in-string word)])
     (char-lower-case? c))

   (and (char-upper-case? (string-ref word 0))
        (for/and ([c (in-string (substring word 1))])
          (char-lower-case? c)))))