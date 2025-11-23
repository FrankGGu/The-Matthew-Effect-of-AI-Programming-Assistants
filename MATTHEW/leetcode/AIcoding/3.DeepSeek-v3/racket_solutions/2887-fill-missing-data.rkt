(define (fill-missing-data products)
  (let loop ([lst products]
             [prev (first products)])
    (if (null? lst)
        '()
        (let* ([current (first lst)]
               [quantity (hash-ref current 'quantity #f)]
               [new-quantity (if (equal? quantity 'None)
                                 (hash-ref prev 'quantity)
                                 quantity)]
               [new-current (hash-set current 'quantity new-quantity)])
          (cons new-current (loop (rest lst) new-current))))))