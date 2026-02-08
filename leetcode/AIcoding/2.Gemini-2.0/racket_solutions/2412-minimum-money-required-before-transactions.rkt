(define (minimum-money transactions)
  (let loop ([transactions transactions] [money 0])
    (if (null? transactions)
        money
        (let* ([gainers (filter (lambda (t) (> (car t) (cadr t))) transactions)]
               [losers (filter (lambda (t) (not (> (car t) (cadr t)))) transactions)]
               [sorted-gainers (sort gainers > #:key car)]
               [sorted-losers (sort losers > #:key cadr)]
               [combined (append sorted-gainers sorted-losers)]
               [min-money (if (null? combined)
                              0
                              (let loop2 ([transactions combined] [current-money 0] [min-needed 0])
                                (if (null? transactions)
                                    min-needed
                                    (let* ([cost (car (car transactions))]
                                           [cash (cadr (car transactions))]
                                           [new-money (+ current-money cash - cost)]
                                           [new-min (min min-needed new-money)])
                                      (loop2 (cdr transactions) new-money new-min)))))]
              )
          (max 0 (- min-money)))))