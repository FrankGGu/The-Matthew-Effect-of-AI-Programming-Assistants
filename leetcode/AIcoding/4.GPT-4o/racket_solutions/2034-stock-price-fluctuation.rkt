(define StockPrice
  (lambda ()
    (define price (hash))
    (define timestamps '())

    (define (update price-timestamp)
      (define timestamp (car price-timestamp))
      (define p (cadr price-timestamp))
      (hash-set! price timestamp p)
      (set! timestamps (cons timestamp timestamps)))

    (define (current)
      (if (null? timestamps)
          0
          (apply max timestamps)))

    (define (maximum)
      (if (null? timestamps)
          0
          (apply max (hash-map (lambda (k v) v) price))))

    (define (minimum)
      (if (null? timestamps)
          0
          (apply min (hash-map (lambda (k v) v) price))))

    (define (fluctuation)
      (if (null? timestamps)
          0
          (- (maximum) (minimum))))

    (define (get-stock-price)
      (lambda (price-timestamp)
        (update price-timestamp)
        (current))
    )

    (define (get-max-fluctuation)
      (lambda ()
        (fluctuation))
    )

    (define (get-max-price)
      (lambda ()
        (maximum))
    )

    (define (get-min-price)
      (lambda ()
        (minimum))
    )

    (list get-stock-price get-max-fluctuation get-max-price get-min-price)))

(define stock-price-instance (StockPrice))
(define get-stock-price (car stock-price-instance))
(define get-max-fluctuation (cadr stock-price-instance))
(define get-max-price (caddr stock-price-instance))
(define get-min-price (cadddr stock-price-instance))