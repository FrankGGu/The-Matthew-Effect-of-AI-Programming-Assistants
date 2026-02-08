(define (find-unique-binary-string nums)
  (define n (length nums))
  (define (generate-binary k)
    (if (zero? k)
        ""
        (string-append (generate-binary (sub1 k)) (if (zero? (random 2)) "0" "1"))))
  (let loop ()
    (let ([candidate (generate-binary n)])
      (if (not (member candidate nums))
          candidate
          (loop)))))