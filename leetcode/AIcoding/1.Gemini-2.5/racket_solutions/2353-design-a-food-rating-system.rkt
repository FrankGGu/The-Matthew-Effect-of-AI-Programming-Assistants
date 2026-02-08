#lang racket

(require data/heap)

(struct food-item (rating cuisine) #:mutable)

(define (FoodRatings foods cuisines ratings)
  (define food-info-map (make-hash))
  (define cuisine-heaps-map (make-hash))

  (for ([food foods] [cuisine cuisines] [rating ratings])
    (hash-set! food-info-map food (food-item rating cuisine))

    (define current-heap
      (hash-ref! cuisine-heaps-map cuisine
                 (lambda () (make-min-heap))))

    (heap-insert! current-heap (list (- rating) food)))

  (define (change-rating food new-rating)
    (define food-item-obj (hash-ref food-info-map food))
    (set-food-item-rating! food-item-obj new-rating)

    (define cuisine (food-item-cuisine food-item-obj))
    (define current-heap (hash-ref cuisine-heaps-map cuisine))
    (heap-insert! current-heap (list (- new-rating) food)))

  (define (highest-rated cuisine)
    (define current-heap (hash-ref cuisine-heaps-map cuisine))

    (let loop ()
      (define top-element (heap-min-element current-heap))
      (define neg-rating (car top-element))
      (define food-name (cadr top-element))

      (define food-item-obj (hash-ref food-info-map food-name))
      (define current-actual-rating (food-item-rating food-item-obj))

      (if (= (- current-actual-rating) neg-rating)
          food-name
          (begin
            (heap-extract-min! current-heap)
            (loop)))))

  (list change-rating highest-rated))