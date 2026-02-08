(define (find-different-binary-string nums)
  (define n (length nums))
  (define (generate-string i)
    (if (= i n)
        ""
        (string-append (if (equal? (string-ref (list-ref nums i) i) #\0) "1" "0")
                       (generate-string (+ i 1)))))
  (generate-string 0))