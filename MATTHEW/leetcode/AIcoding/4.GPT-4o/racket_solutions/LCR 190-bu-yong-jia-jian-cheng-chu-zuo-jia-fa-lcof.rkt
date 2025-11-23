(define (encrypt nums)
  (define (helper lst)
    (if (null? lst)
        '()
        (cons (car lst) (helper (cdr lst)))))

  (define n (length nums))
  (define mid (/ n 2))
  (define first-half (take nums mid))
  (define second-half (drop nums mid))

  (map + first-half (reverse second-half)))

(define (encrypt-array nums)
  (encrypt nums))