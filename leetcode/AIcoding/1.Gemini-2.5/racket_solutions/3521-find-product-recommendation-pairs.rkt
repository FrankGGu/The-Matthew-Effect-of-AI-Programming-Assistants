#lang racket

(define (find-product-recommendation-pairs transactions)
  ;; 1. Group products by user
  ;; user-products: hash table {user-id -> list of product-ids}
  (define user-products (make-hash))
  (for-each
   (lambda (transaction)
     (define user-id (first transaction))
     (define product-id (second transaction))
     (hash-set! user-products user-id
                (cons product-id (hash-ref user-products user-id '()))))
   transactions)

  ;; For each user, sort and remove duplicates from their product list
  ;; This ensures consistent pair generation (e.g., ("A" "B") not ("B" "A"))
  (for-each
   (lambda (user-id)
     (hash-set! user-products user-id
                (sort (remove-duplicates (hash-ref user-products user-id)) string<?)))
   (hash-keys user-products))

  ;; 2. Generate all unique pairs for each user and count their occurrences
  ;; pair-counts: hash table {pair (list of two product-ids) -> count}
  (define pair-counts (make-hash))
  (for-each
   (lambda (user-id)
     (define products (hash-ref user-products user-id))
     (for ([i (in-range (length products))])
       (for ([j (in-range (+ i 1) (length products))])
         (define p1 (list-ref products i))
         (define p2 (list-ref products j))
         ;; Ensure the pair is always represented as (smaller_product larger_product)
         ;; This is guaranteed by sorting the products list first.
         (define pair (list p1 p2))
         (hash-set! pair-counts pair
                    (+ 1 (hash-ref pair-counts pair 0))))))
   (hash-keys user-products))

  ;; 3. Filter pairs based on a minimum frequency
  ;; A common interpretation for "recommendation pairs" implies at least 2 co-occurrences.
  (define min-frequency 2) 

  (define result-pairs '())
  (for-each
   (lambda (pair)
     (define count (hash-ref pair-counts pair))
     (when (>= count min-frequency)
       (set! result-pairs (cons pair result-pairs))))
   (hash-keys pair-counts))

  ;; 4. Sort the result pairs lexicographically
  (sort result-pairs
        (lambda (pair1 pair2)
          (or (string<? (first pair1) (first pair2))
              (and (string=? (first pair1) (first pair2))
                   (string<? (second pair1) (second pair2)))))))