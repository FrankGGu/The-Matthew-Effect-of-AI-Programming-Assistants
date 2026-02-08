(define (letter-combinations digits)
  (define digit-map
    (hash
     #\2 "abc"
     #\3 "def"
     #\4 "ghi"
     #\5 "jkl"
     #\6 "mno"
     #\7 "pqrs"
     #\8 "tuv"
     #\9 "wxyz"))

  (define (combine-two-lists list1 list2)
    (apply append
           (map (lambda (s1)
                  (map (lambda (s2)
                         (string-append s1 s2))
                       list2))
                list1)))

  (define (helper current-digits)
    (if (string=? current-digits "")
        (list "")
        (let* ((first-digit (string-ref current-digits 0))
               (letters-str (hash-ref digit-map first-digit))
               (letters-list (map string (string->list letters-str)))
               (rest-combinations (helper (substring current-digits 1))))
          (combine-two-lists letters-list rest-combinations))))

  (if (string=? digits "")
      (list)
      (helper digits)))