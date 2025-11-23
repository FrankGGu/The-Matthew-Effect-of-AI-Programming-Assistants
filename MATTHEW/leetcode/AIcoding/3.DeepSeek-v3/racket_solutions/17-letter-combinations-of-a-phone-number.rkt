(define (letter-combinations digits)
  (define digit-to-letters
    (hash
     #\2 "abc"
     #\3 "def"
     #\4 "ghi"
     #\5 "jkl"
     #\6 "mno"
     #\7 "pqrs"
     #\8 "tuv"
     #\9 "wxyz"))

  (define (combine current remaining)
    (if (null? remaining)
        (list current)
        (let* ((digit (car remaining))
               (letters (string->list (hash-ref digit-to-letters digit))))
          (append-map (lambda (c) (combine (string-append current (string c)) (cdr remaining))) letters))))

  (if (string=? digits "")
      '()
      (combine "" (string->list digits))))