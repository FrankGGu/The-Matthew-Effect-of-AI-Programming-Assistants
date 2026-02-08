(define (maximum-wealth accounts)
  (define (row-sum row)
    (apply + row))
  (apply max (map row-sum accounts)))