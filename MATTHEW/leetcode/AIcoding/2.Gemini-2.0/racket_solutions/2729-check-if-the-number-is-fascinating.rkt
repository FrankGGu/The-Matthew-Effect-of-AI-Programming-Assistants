(define (is-fascinating n)
  (let* ([s (number->string n)]
         [s2 (number->string (* 2 n))]
         [s3 (number->string (* 3 n))]
         [combined-str (string-append s s2 s3)]
         [len (string-length combined-str)])
    (and (= len 9)
         (equal? (sort (string->list combined-str) char<?)
                 (sort (string->list "123456789") char<?)))))