(define (make-bank-system balance)
  (let ([accounts (vector-immutableize (vector #f))])
    (for/list ([i (in-range (length balance))])
      (vector-set! accounts i (list-ref balance i)))
    (define (is-valid-account account)
      (and (>= account 1) (<= account (vector-length accounts))))
    (define (transfer account1 account2 money)
      (if (and (is-valid-account account1) (is-valid-account account2)
               (>= (vector-ref accounts (- account1 1)) money))
          (begin
            (vector-set! accounts (- account1 1) (- (vector-ref accounts (- account1 1)) money))
            (vector-set! accounts (- account2 1) (+ (vector-ref accounts (- account2 1)) money))
            #t)
          #f))
    (define (deposit account money)
      (if (and (is-valid-account account) (positive? money))
          (begin
            (vector-set! accounts (- account 1) (+ (vector-ref accounts (- account 1)) money))
            #t)
          #f))
    (define (withdraw account money)
      (if (and (is-valid-account account) (>= (vector-ref accounts (- account 1)) money))
          (begin
            (vector-set! accounts (- account 1) (- (vector-ref accounts (- account 1)) money))
            #t)
          #f))
    (define (get-balance account)
      (if (is-valid-account account)
          (vector-ref accounts (- account 1))
          -1))
    (define (bank-system-interface msg . args)
      (case msg
        [(transfer) (apply transfer args)]
        [(deposit) (apply deposit args)]
        [(withdraw) (apply withdraw args)]
        [(get-balance) (apply get-balance args)]
        [else (error "Invalid message")]))
    bank-system-interface))