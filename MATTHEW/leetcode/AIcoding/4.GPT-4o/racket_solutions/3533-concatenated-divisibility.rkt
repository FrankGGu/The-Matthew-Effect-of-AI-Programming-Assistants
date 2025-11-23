(define (concatenatedDivisibility nums)
  (define (concat-numbers a b)
    (string->number (string-append (number->string a) (number->string b))))

  (define (check-divisibility n)
    (for/fold ([result #t]) ([i (in-range 1 (add1 (length nums)))])
      (if (zero? (modulo n i))
          result
          #f)))

  (for/fold ([count 0]) ([num nums])
    (for/fold ([n (concat-numbers count num)]) ([i (in-range 1 (add1 (length nums)))])
      (if (check-divisibility n)
          (add1 count)
          count))))

  (check-divisibility (apply concat (map number->string nums)))
)

(define (main)
  (display (concatenatedDivisibility '(1 2 3 4 5))))
(main)