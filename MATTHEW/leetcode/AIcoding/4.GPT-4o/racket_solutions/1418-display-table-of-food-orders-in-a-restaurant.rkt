(define (displayTable orders)
  (define table (make-hash))
  (define food-items (make-hash))

  (for-each 
    (lambda (order)
      (define table-num (string->number (list-ref order 1)))
      (define food-item (list-ref order 2))

      (hash-set! table table-num (cons food-item (hash-ref table table-num '())))
      (hash-set! food-items food-item #t))
    orders)

  (define sorted-tables (sort (hash-map->list table) (lambda (a b) (< (car a) (car b)))))
  (define sorted-foods (sort (hash-map->list food-items) (lambda (a b) (string<? (car a) (car b)))))

  (define result (cons (cons "Table" (map car sorted-foods)) '()))

  (for-each 
    (lambda (table-entry)
      (define table-num (car table-entry))
      (define food-counts (make-hash))

      (for-each 
        (lambda (food-item)
          (hash-set! food-counts food-item (+ 1 (hash-ref food-counts food-item 0))))
        (cdr table-entry))

      (define row (cons table-num '()))

      (for-each 
        (lambda (food-item)
          (define count (hash-ref food-counts food-item 0))
          (set! row (cons (if (= count 0) 0 count) row)))
        (map car sorted-foods))

      (set! result (cons (cons table-num (reverse row)) result)))
    sorted-tables)

  (reverse result))