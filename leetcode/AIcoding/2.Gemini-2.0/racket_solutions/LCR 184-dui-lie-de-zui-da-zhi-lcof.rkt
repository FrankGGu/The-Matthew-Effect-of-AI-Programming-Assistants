(define (CheckoutSystem products prices)
  (let ((product-map (make-hash)))
    (for ((i (in-range (length products))))
      (hash-set! product-map (list-ref products i) (list-ref prices i)))
    (define items '())
    (define total 0)

    (define (add product)
      (if (hash-has-key? product-map product)
          (begin
            (set! items (cons product items))
            (set! total (+ total (hash-ref product-map product)))
            void)
          void))

    (define (remove product)
      (let loop ((lst items) (acc '()))
        (cond
          [(null? lst)
           (set! items acc)
           void]
          [(equal? (car lst) product)
           (set! total (- total (hash-ref product-map product)))
           (set! items (append acc (cdr lst)))
           void]
          [else
           (loop (cdr lst) (append acc (list (car lst))))])))

    (define (getTotal)
      (cond
        [(< total 0) 0]
        [else total]))

    (define (getProducts)
      items)

    (define (reset)
      (set! items '())
      (set! total 0)
      void)

    (hash 'add add 'remove remove 'getTotal getTotal 'getProducts getProducts 'reset reset)))