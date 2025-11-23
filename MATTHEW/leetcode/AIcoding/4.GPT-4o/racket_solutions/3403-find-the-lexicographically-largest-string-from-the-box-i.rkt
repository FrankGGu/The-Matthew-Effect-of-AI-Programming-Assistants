(define (findLargestString s)
  (define (helper s box)
    (if (string=? s "")
        ""
        (let* ((max-char (apply max (string->list s)))
               (new-s (string-filter (lambda (c) (not (member c (string->list box)))) s)))
          (if (string=? new-s "")
              ""
              (string-append (string (if (char=? max-char #\z) max-char (if (char=? max-char #\a) #\a #\z)))
                             (helper (string-filter (lambda (c) (not (char=? c max-char))) s) box)))))))
  (helper s ""))

(findLargestString "abcde")