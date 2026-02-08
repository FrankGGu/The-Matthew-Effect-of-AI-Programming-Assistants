#lang racket

(define (bank-account-summary-ii users transactions)
  (define account-balances
    (for/fold ((balances (make-hash)))
              ((transaction transactions))
      (define account (hash-ref transaction 'account))
      (define amount (hash-ref transaction 'amount))
      (hash-set! balances account (+ (hash-ref balances account 0) amount))
      balances))

  (define user-names
    (for/fold ((names (make-hash)))
              ((user users))
      (hash-set! names (hash-ref user 'account) (hash-ref user 'name))
      names))

  (for/list ((account-id (hash-keys account-balances)))
    (define balance (hash-ref account-balances account-id))
    (when (> balance 10000)
      (hash 'name (hash-ref user-names account-id)
            'balance balance))))