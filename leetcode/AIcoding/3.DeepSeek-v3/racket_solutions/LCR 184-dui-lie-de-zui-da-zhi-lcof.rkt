(define checkout-system%
  (class object%
    (super-new)
    (init-field)
    (define prices (make-hash))
    (define items (make-hash))

    (define/public (get-prices)
      prices)

    (define/public (get-items)
      items)

    (define/public (scan name price)
      (hash-set! prices name price)
      (hash-update! items name (lambda (v) (+ v 1)) 0))

    (define/public (remove name)
      (when (hash-has-key? items name)
        (let ([count (hash-ref items name)])
          (if (= count 1)
              (hash-remove! items name)
              (hash-set! items name (- count 1)))))

    (define/public (checkout)
      (let ([total 0])
        (hash-for-each items
          (lambda (name count)
            (set! total (+ total (* count (hash-ref prices name))))))
        (hash-clear! items)
        total))))