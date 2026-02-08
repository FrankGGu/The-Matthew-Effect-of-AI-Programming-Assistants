(define (invalidTransactions transactions)
  (define (parse-transaction t)
    (let* ((fields (string-split t ","))
           (name (list-ref fields 0))
           (time (string->number (list-ref fields 1)))
           (amount (string->number (list-ref fields 2)))
           (city (list-ref fields 3)))
      (list name time amount city)))

  (define (invalid? txn1 txn2)
    (and (not (equal? (car txn1) (car txn2))) 
         (<= (abs (- (cadr txn1) (cadr txn2))) 60)
         (> (caddr txn1) 1000)))

  (define transactions-list (map parse-transaction transactions))
  (define invalid-transaction-names
    (filter (lambda (txn)
              (or (> (caddr txn) 1000)
                  (for/or ([t transactions-list])
                    (invalid? txn t))))
            transactions-list))

  (define (transaction-to-string txn)
    (string-append (car txn) "," (number->string (cadr txn)) "," 
                   (number->string (caddr txn)) "," (last txn)))

  (map transaction-to-string invalid-transaction-names))

(invalidTransactions '("alice,20,800,mtv","alice,50,1200,mtv"))