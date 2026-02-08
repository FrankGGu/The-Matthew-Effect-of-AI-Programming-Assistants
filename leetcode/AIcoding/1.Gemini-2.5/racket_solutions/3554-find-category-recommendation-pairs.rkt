#lang racket

(define (find-category-recommendation-pairs data)
  ;; Step 1: Aggregate categories for each user
  (define user-categories-ht
    (for/fold (user-cat-ht (make-hash))
              ((row data))
      (define user-id (first row))
      (define category (third row))
      (hash-set! user-cat-ht
                 user-id
                 (set-add (hash-ref user-cat-ht user-id (set)) category))
      user-cat-ht))

  ;; Step 2: Generate all unique category pairs for each user and count their occurrences
  (define pair-counts
    (for/fold (pair-counts-ht (make-hash))
              (((user-id categories) (in-hash user-categories-ht)))
      ;; Convert set to sorted list to ensure consistent pair ordering (cat1, cat2 where cat1 < cat2)
      (define sorted-categories (sort (set->list categories) string<?))
      (for ((i (in-range (length sorted-categories))))
        (for ((j (in-range (+ i 1) (length sorted-categories))))
          (define cat1 (list-ref sorted-categories i))
          (define cat2 (list-ref sorted-categories j))
          (define pair (list cat1 cat2)) ; Use a list as key for hash table
          (hash-set! pair-counts-ht pair (+ (hash-ref pair-counts-ht pair 0) 1))))
      pair-counts-ht))

  ;; Step 3: Format the output as a list of (category1, category2, count) and sort
  (define result
    (for/list (((pair count) (in-hash pair-counts)))
      (list (first pair) (second pair) count)))

  ;; Sort by count in descending order, then by category1 in ascending order,
  ;; then by category2 in ascending order.
  (sort result
        (lambda (a b)
          (cond
            ((> (third a) (third b)) #t) ; Count descending
            ((< (third a) (third b)) #f)
            ((string<? (first a) (first b)) #t) ; Category 1 ascending
            ((string>? (first a) (first b)) #f)
            ((string<? (second a) (second b)) #t) ; Category 2 ascending
            (else #f)))))