(define (latest-time-by-replacing-hidden-digits time)
  (let* ([chars (string->list time)]
         [h1-char (list-ref chars 0)]
         [h2-char (list-ref chars 1)]
         [m1-char (list-ref chars 3)]
         [m2-char (list-ref chars 4)])

    (let* ([final-h1 (cond
                       [(char=? h1-char #\?)
                        (if (or (char=? h2-char #\?)
                                (char<=? h2-char #\3))
                            #\2
                            #\1)]
                       [else h1-char])]
           [final-h2 (cond
                       [(char=? h2-char #\?)
                        (if (char=? final-h1 #\2)
                            #\3
                            #\9)]
                       [else h2-char])]
           [final-m1 (if (char=? m1-char #\?) #\5 m1-char)]
           [final-m2 (if (char=? m2-char #\?) #\9 m2-char)])

      (list->string (list final-h1 final-h2 #\: final-m1 final-m2)))))