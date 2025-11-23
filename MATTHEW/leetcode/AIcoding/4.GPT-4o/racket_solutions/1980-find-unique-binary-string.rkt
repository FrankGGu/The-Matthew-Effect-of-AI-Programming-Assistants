(define (find-unique-binary-string nums)
  (define (helper prefix nums)
    (if (null? nums)
        (if (not (member prefix nums))
            prefix
            #f)
        (let ((bit (car nums)))
          (let ((next-prefix (string-append prefix (number->string bit))))
            (or (helper (string-append next-prefix "0") (cdr nums))
                (helper (string-append next-prefix "1") (cdr nums)))))))
  (helper "" nums))

(find-unique-binary-string '("00" "01"))