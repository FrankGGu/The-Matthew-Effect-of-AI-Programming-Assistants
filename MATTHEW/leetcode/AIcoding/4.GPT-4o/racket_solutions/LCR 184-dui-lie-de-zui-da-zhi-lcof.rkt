#lang racket

(define SimpleCashier
  (class object%
    (super-new)
    (define/override (initialize n)
      (set! items (make-vector n 0))
      (set! prices (make-vector n 0))
      (set! current 0)
      (set! total 0))

    (define items #f)
    (define prices #f)
    (define current #f)
    (define total #f)

    (define/public (setItemPrice itemId price)
      (vector-set! prices itemId price))

    (define/public (addItem itemId)
      (vector-set! items itemId (add1 (vector-ref items itemId)))
      (set! total (+ total (vector-ref prices itemId))))

    (define/public (getTotal)
      total)

    (define/public (checkout)
      (define result total)
      (set! total 0)
      (for ([i (in-range (vector-length items))])
        (vector-set! items i 0))
      result)))

(define (createCashier n)
  (new SimpleCashier n))