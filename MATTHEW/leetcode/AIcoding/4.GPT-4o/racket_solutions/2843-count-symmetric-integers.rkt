(define (count-symmetric-integers low high)
  (define (symmetric? n)
    (let* ((s (number->string n))
           (len (string-length s)))
      (and (even? len)
           (= (string->number (substring s 0 (/ len 2)))
              (string->number (substring s (/ len 2)))))))
  (define (count-helper n count)
    (if (> n high)
        count
        (count-helper (+ n 1) (if (symmetric? n) (+ count 1) count))))
  (count-helper low 0))

(count-symmetric-integers 1 1000)