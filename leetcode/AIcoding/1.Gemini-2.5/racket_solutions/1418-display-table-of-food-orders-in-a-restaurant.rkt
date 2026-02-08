#lang racket

(define (display-table orders)
  (define all-food-items (make-hash))
  (define all-table-numbers (make-hash))
  (define table-food-counts (make-hash))

  (for-each
   (lambda (order)
     (define table-number-str (list-ref order 1))
     (define food-item (list-ref order 2))

     (hash-set! all-food-items food-item #t)
     (hash-set! all-table-numbers table-number-str #t)

     (define food-counts-for-table
       (hash-ref! table-food-counts table-number-str (lambda () (make-hash))))

     (hash-set! food-counts-for-table
                food-item
                (+ 1 (hash-ref food-counts-for-table food-item 0))))
   orders)

  (define sorted-food-items
    (sort (hash-keys all-food-items) string<?))

  (define sorted-table-numbers-str
    (map number->string
         (sort (map string->number (hash-keys all-table-numbers)) <)))

  (define header-row (cons "Table" sorted-food-items))

  (define data-rows
    (map
     (lambda (table-num-str)
       (define current-row (list table-num-str))
       (define food-counts-for-this-table
         (hash-ref table-food-counts table-num-str (make-hash)))

       (for-each
        (lambda (food-item)
          (define count (hash-ref food-counts-for-this-table food-item 0))
          (set! current-row (append current-row (list (number->string count)))))
        sorted-food-items)
       current-row)
     sorted-table-numbers-str))

  (cons header-row data-rows))