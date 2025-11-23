(define/contract (minimum-cost nums)
  (-> (listof exact-integer?) exact-integer?)
  (define (palindrome-cost x)
    (define (is-palindrome? s)
      (equal? s (reverse s)))
    (let loop ([n x] [delta 0])
      (if (is-palindrome? (string->list (number->string n)))
          delta
          (loop (add1 n) (add1 delta)))))
  (define (find-min-cost nums target)
    (for/sum ([num nums])
      (abs (- num target))))
  (define targets
    (let ([sorted (sort nums <)])
      (list (list-ref sorted (quotient (length sorted) 2))
      ))
  (define possible-targets
    (append targets
            (for/list ([t targets])
              (let ([s (number->string t)])
                (string->number (list->string (reverse (string->list s))))))))
  (apply min
         (for/list ([t possible-targets])
           (find-min-cost nums (palindrome-cost t)))))