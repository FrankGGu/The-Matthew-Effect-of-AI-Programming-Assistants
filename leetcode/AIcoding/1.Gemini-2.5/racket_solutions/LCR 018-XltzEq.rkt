(define (is-palindrome s)
  (let* ([lower-s (string-downcase s)]
         [filtered-chars (filter (lambda (c)
                                   (or (char-alphabetic? c)
                                       (char-numeric? c)))
                                 (string->list lower-s))]
         [filtered-s (list->string filtered-chars)])
    (let ([len (string-length filtered-s)])
      (if (zero? len)
          #t
          (let loop ([i 0]
                     [j (- len 1)])
            (if (>= i j)
                #t
                (if (char=? (string-ref filtered-s i)
                            (string-ref filtered-s j))
                    (loop (+ i 1) (- j 1))
                    #f)))))))