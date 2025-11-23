(define cashier%
  (class object%
    (super-new)
    (init-field n discount products prices)
    (field [count 0])

    (define/public (get-bill product amount)
      (set! count (add1 count))
      (let ([total 0])
        (for ([p product] [a amount])
          (set! total (+ total (* (hash-ref prices p) a))))
      (if (zero? (modulo count n))
          (* total (- 1 (/ discount 100)))
          total))))

(define (make-cashier n discount products prices)
  (new cashier% [n n] [discount discount] [products products] [prices (make-hash (map cons products prices))]))