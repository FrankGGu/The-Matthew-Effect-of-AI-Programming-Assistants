#lang racket

(define/public (bank-account-summary-II users accounts transactions)
  (define user-balances (make-hash))

  (for ([user (in-list users)])
    (hash-set! user-balances (vector-ref user 0) 0))

  (for ([account (in-list accounts)])
    (for ([transaction (in-list transactions)])
      (define account-id (vector-ref transaction 1))
      (define amount (vector-ref transaction 2))
      (hash-update! user-balances 
                    (vector-ref (findf (lambda (a) (equal? (vector-ref a 0) account-id)) accounts) 1)
                    (lambda (bal) (+ bal amount))
                    (lambda () 0)))

  (define result '())
  (for ([(user-id balance) (in-hash user-balances)])
    (when (> balance 10000)
      (set! result (cons (vector (vector-ref (findf (lambda (u) (equal? (vector-ref u 0) user-id)) users) 1)
                                 balance)
                         result))))

  (list->vector result))