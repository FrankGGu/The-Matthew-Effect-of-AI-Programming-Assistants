#lang racket

(define ATM
  (class object%
    (super-new)

    (define/override (init)
      (set! balance 0)
      (set! bank-notes (vector 0 0 0 0 0)))

    (define balance 0)
    (define bank-notes (vector 0 0 0 0 0))

    (define (withdraw amount)
      (define denominations (vector 20 50 100 200 500))
      (define notes (vector 0 0 0 0 0))
      (define total 0)
      (define i 4)
      (while (and (< i 5) (> amount 0))
        (define note-count (min (floor (/ amount (vector-ref denominations i)))
                                 (vector-ref bank-notes i)))
        (vector-set! notes i note-count)
        (set! amount (- amount (* note-count (vector-ref denominations i))))
        (set! total (+ total note-count))
        (set! i (- i 1)))
      (if (or (> amount 0) (= total 0))
          (error "Cannot withdraw the requested amount")
          (begin
            (for ([j (in-range 5)])
              (vector-set! bank-notes j (- (vector-ref bank-notes j) (vector-ref notes j))))
            (set! balance (- balance total))
            notes)))

    (define (deposit bank-notes-input)
      (for ([i (in-range 5)])
        (vector-set! bank-notes i (+ (vector-ref bank-notes i) (vector-ref bank-notes-input i))))
      (set! balance (+ balance (foldl (lambda (x acc) (+ acc (* x (vector-ref (vector 20 50 100 200 500) i))))
                                       0
                                       bank-notes-input)))

    (define (get_balance)
      balance)

    (define (get_banknotes)
      (vector->list bank-notes))

    (define/public (withdraw amount)
      (withdraw amount))

    (define/public (deposit bank-notes-input)
      (deposit bank-notes-input))

    (define/public (get_balance)
      (get_balance))

    (define/public (get_banknotes)
      (get_banknotes))
    ))

(define atm (new ATM))