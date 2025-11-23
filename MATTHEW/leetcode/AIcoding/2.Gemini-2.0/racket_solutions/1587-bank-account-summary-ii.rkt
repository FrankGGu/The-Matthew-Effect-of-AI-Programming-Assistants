(define (bank-account-summary accounts transactions)
  (let* ((account-balances (make-hash))
         (update-account-balances
          (lambda (account-id balance-change)
            (let ((current-balance (hash-ref account-balances account-id 0)))
              (hash-set! account-balances account-id (+ current-balance balance-change))))))
    (for ([transaction transactions])
      (update-account-balances (list-ref transaction 0) (list-ref transaction 1)))
    (let ((result '()))
      (hash-for-each account-balances
                     (lambda (account-id balance)
                       (when (>= balance 10000)
                         (set! result (cons (list account-id balance) result)))))
      result)))