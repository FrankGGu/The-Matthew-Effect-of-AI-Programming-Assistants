(define (letter-combinations digits)
  (define digit->letters (hash #\2 "abc" #\3 "def" #\4 "ghi" #\5 "jkl" #\6 "mno" #\7 "pqrs" #\8 "tuv" #\9 "wxyz"))

  (define (combine current remaining-digits)
    (cond
      [(empty? remaining-digits) (list current)]
      [else
       (let* ([digit (car remaining-digits)]
              [letters (hash-ref digit->letters digit)])
         (foldr append '()
                (map (lambda (letter) (combine (string-append current (string letter)) (cdr remaining-digits)))
                     (string->list letters))))]))

  (if (string=? digits "")
      '()
      (combine "" (string->list digits))))