(define (minimizeString s)
  (define (replace-qs str)
    (if (string=? str "")
        ""
        (let* ([first-char (string-ref str 0)]
               [next-chars (replace-qs (substring str 1))])
          (if (char=? first-char #\?)
              (let ([prev-char (if (string=? next-chars "")
                                   #\0
                                   (string-ref next-chars 0))])
                (cond
                  [(char=? prev-char #\0) (string-append (string #\a) next-chars)]
                  [(char=? prev-char #\a) (string-append (string #\b) next-chars)]
                  [else (string-append (string #\a) next-chars)])
              )
              (string-append (string first-char) next-chars)))))
  (replace-qs s))

(define (main)
  (display (minimizeString "??yw?ipkj?")))

(main)