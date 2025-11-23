#lang racket

(define-struct account (balance))

(define (make-bank-system)
  (let ((accounts (make-hash)))
    (lambda (command . args)
      (cond
        [(equal? command 'create-account)
         (hash-set! accounts (car args) (make-account 0))]
        [(equal? command 'transfer)
         (let* ((from (car args))
                (to (cadr args))
                (amount (caddr args))
                (from-acc (hash-ref accounts from #f))
                (to-acc (hash-ref accounts to #f)))
           (if (and from-acc to-acc (< (account-balance from-acc) amount))
               #f
               (begin
                 (set-account-balance! from-acc (- (account-balance from-acc) amount))
                 (set-account-balance! to-acc (+ (account-balance to-acc) amount))
                 #t)))]
        [(equal? command 'deposit)
         (let ((acc (hash-ref accounts (car args) #f)))
           (if acc
               (begin
                 (set-account-balance! acc (+ (account-balance acc) (cadr args)))
                 #t)
               #f))]
        [(equal? command 'withdraw)
         (let ((acc (hash-ref accounts (car args) #f)))
           (if (and acc (>= (account-balance acc) (cadr args)))
               (begin
                 (set-account-balance! acc (- (account-balance acc) (cadr args)))
                 #t)
               #f))]))))