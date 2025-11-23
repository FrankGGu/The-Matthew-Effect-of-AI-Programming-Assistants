(define (getLengthOfTransformedString s)
  (define (transform c)
    (if (char=? c #\a)
        #\b
        (if (char=? c #\b)
            #\c
            (if (char=? c #\c)
                #\d
                (if (char=? c #\d)
                    #\e
                    c)))))
  (define transformed-string (map transform (string->list s)))
  (string-length (list->string transformed-string)))

(getLengthOfTransformedString "abcde")