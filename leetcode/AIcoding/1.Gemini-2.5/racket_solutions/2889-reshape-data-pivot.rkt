#lang racket

(define (pivot-products products)
  (define product-map (make-hash))

  (for-each (lambda (row)
              (define product_id (list-ref row 0))
              (define store (list-ref row 1))
              (define price (list-ref row 2))

              (define store-prices (hash-ref product-map product_id (lambda () (make-hash))))
              (hash-set! store-prices store price)
              (hash-set! product-map product_id store-prices))
            products)

  (define result-rows (list))
  (define sorted-product-ids (sort (hash-keys product-map) <))

  (for-each (lambda (product_id)
              (define store-prices (hash-ref product-map product_id))
              (define store1-price (hash-ref store-prices "store1" #f))
              (define store2-price (hash-ref store-prices "store2" #f))
              (define store3-price (hash-ref store-prices "store3" #f))
              (set! result-rows (cons (list product_id store1-price store2-price store3-price) result-rows)))
            sorted-product-ids)

  (reverse result-rows))