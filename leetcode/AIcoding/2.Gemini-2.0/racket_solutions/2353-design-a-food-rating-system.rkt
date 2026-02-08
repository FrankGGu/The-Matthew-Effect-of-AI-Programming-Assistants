(define (make-FoodRatings foods cuisines ratings)
  (let* ([food-cuisine (make-hash)]
         [food-rating (make-hash)]
         [cuisine-foods (make-hash)])
    (for ([i (in-range (length foods))])
      (let ([food (list-ref foods i)]
            [cuisine (list-ref cuisines i)]
            [rating (list-ref ratings i)])
        (hash-set! food-cuisine food cuisine)
        (hash-set! food-rating food rating)
        (when (not (hash-has-key? cuisine-foods cuisine))
          (hash-set! cuisine-foods cuisine (make-heap < #:key (lambda (food) (list (- (hash-ref food-rating food)) food)))))
        (heap-add! (hash-ref cuisine-foods cuisine) food)))
    (define (changeRating food newRating)
      (hash-set! food-rating food newRating)
      (let ([cuisine (hash-ref food-cuisine food)])
        (hash-set! cuisine-foods cuisine (make-heap < #:key (lambda (food) (list (- (hash-ref food-rating food)) food))))
        (for ([food (in-vector (heap-elts (hash-ref cuisine-foods cuisine))))]
             (heap-add! (hash-ref cuisine-foods cuisine) food))))
    (define (highestRated cuisine)
      (let ([h (hash-ref cuisine-foods cuisine)])
        (heap-top h)))
    (struct FoodRatings (changeRating highestRated))
    (FoodRatings changeRating highestRated)))