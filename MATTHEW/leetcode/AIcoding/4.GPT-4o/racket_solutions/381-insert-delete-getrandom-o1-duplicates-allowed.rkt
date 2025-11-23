#lang racket

(define InsertDeleteGetRandom
  (class object%
    (init)
    (define/public (insert x)
      (set! elements (cons x elements))
      (set! index (add1 index))
      (set! idx-map (hash-set idx-map x index)))

    (define/public (remove x)
      (when (hash-has? idx-map x)
        (define idx (hash-ref idx-map x))
        (set! elements (append (take elements idx) (drop elements (add1 idx))))
        (hash-remove! idx-map x)))

    (define/public (getRandom)
      (if (null? elements)
          (error "No elements to select from")
          (list-ref elements (random (length elements)))))

    (define/override (init)
      (set! elements '())
      (set! idx-map (make-hash))
      (set! index 0))

    (define elements '())
    (define idx-map (make-hash))
    (define index 0)))

(define insert-delete-get-random (new InsertDeleteGetRandom))