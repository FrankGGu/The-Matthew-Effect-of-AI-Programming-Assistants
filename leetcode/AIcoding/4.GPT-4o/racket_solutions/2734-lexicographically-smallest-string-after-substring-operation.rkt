(define (smallestString s)
  (define (replace-char c)
    (if (char=? c #\z)
        #\a
        (integer->char (+ (char->integer c) 1))))
  (define (helper str)
    (if (string=? str "")
        ""
        (string-append (string (replace-char (string-ref str 0)))
                       (helper (substring str 1)))))
  (helper s))