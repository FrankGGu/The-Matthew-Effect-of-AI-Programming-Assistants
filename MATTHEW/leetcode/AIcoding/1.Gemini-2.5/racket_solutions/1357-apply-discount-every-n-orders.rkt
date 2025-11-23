#lang racket

(struct cashier (n discount product-prices order-count) #:mutable)

(define (make-cashier n discount products prices)
  (define product-prices-map (make-hash))
  (for ([prod-id products]
        [price prices])
    (hash-set! product-prices-map prod-id price))
  (cashier n discount product-prices-map 0))

(define (cashier-get-bill c customer-products amount)
  (set-cashier-order-count! c (+ (cashier-order-count c) 1))

  (define current-bill 0.0)
  (for ([prod-id customer-products]
        [qty amount])
    (define price (hash-ref (cashier-product-prices c) prod-id))
    (set! current-bill (+ current-bill (* price qty))))

  (when (= (modulo (cashier-order-count c) (cashier-n c)) 0)
    (set! current-bill (* current-bill (- 1.0 (/ (cashier-discount c) 100.0)))))

  current-bill)