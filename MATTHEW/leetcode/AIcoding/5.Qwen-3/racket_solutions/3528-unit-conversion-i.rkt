(define (unit-conversion input)
  (let* ([parts (string-split input)]
         [value (string->number (list-ref parts 0))]
         [from-unit (list-ref parts 1)]
         [to-unit (list-ref parts 2)])
    (cond
      [(and (equal? from-unit "m") (equal? to-unit "cm")) (* value 100)]
      [(and (equal? from-unit "cm") (equal? to-unit "m")) (/ value 100)]
      [(and (equal? from-unit "m") (equal? to-unit "km")) (/ value 1000)]
      [(and (equal? from-unit "km") (equal? to-unit "m")) (* value 1000)]
      [(and (equal? from-unit "cm") (equal? to-unit "km")) (/ value 100000)]
      [(and (equal? from-unit "km") (equal? to-unit "cm")) (* value 100000)]
      [else 0])))