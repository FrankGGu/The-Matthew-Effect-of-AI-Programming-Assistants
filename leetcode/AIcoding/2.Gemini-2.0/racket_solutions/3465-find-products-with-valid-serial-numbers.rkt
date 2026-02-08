(define (solve db)
  (define products
    (hash-ref (db-query db "SELECT product_id FROM Products") 0))
  (define valid_serials
    (hash-ref (db-query db "SELECT product_id FROM Valid_Serial") 0))
  (define result
    (filter (lambda (product-id) (member product-id valid-serials)) products))
  (define result-table
    (list (hash 'product_id result)))
  result-table)