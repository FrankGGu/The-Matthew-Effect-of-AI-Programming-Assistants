(define food-rating-system%
  (class object%
    (super-new)
    (init-field foods cuisines ratings)

    (define food-to-cuisine (make-hash))
    (define cuisine-to-foods (make-hash))
    (define food-to-rating (make-hash))

    (for ([food foods]
          [cuisine cuisines]
          [rating ratings])
      (hash-set! food-to-cuisine food cuisine)
      (hash-set! food-to-rating food rating)
      (let ([foods-set (hash-ref cuisine-to-foods cuisine (set))])
        (hash-set! cuisine-to-foods cuisine (set-add foods-set (cons (- rating) food))))

    (define/public (change-rating food newRating)
      (let* ([cuisine (hash-ref food-to-cuisine food)]
             [oldRating (hash-ref food-to-rating food)]
             [foods-set (hash-ref cuisine-to-foods cuisine)])
        (hash-set! cuisine-to-foods cuisine (set-remove foods-set (cons (- oldRating) food)))
        (hash-set! cuisine-to-foods cuisine (set-add (hash-ref cuisine-to-foods cuisine) (cons (- newRating) food)))
        (hash-set! food-to-rating food newRating)))

    (define/public (highest-rated cuisine)
      (let ([foods-set (hash-ref cuisine-to-foods cuisine)])
        (if (set-empty? foods-set)
            ""
            (cdr (set-first foods-set)))))))

(define (make-food-ratings foods cuisines ratings)
  (new food-rating-system% [foods foods] [cuisines cuisines] [ratings ratings]))

(define (food-ratings-change-rating obj food newRating)
  (send obj change-rating food newRating))

(define (food-ratings-highest-rated obj cuisine)
  (send obj highest-rated cuisine))