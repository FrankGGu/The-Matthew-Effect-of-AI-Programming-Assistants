(define (FoodRatings foods ratings)
  (define food-rating (make-hash))
  (define rating-food (make-hash))

  (for-each (lambda (food)
              (hash-set! food-rating food (hash-ref ratings food))
              (hash-set! rating-food (hash-ref ratings food) (cons food (hash-ref rating-food (hash-ref ratings food) '()))))
              ) foods)

  (define (change-rating food new-rating)
    (let* ((old-rating (hash-ref food-rating food))
           (old-foods (hash-ref rating-food old-rating '()))
           (new-foods (cons food (hash-ref rating-food new-rating '()))))
      (hash-set! food-rating food new-rating)
      (hash-set! rating-food old-rating (remove (lambda (f) (equal? f food)) old-foods))
      (hash-set! rating-food new-rating new-foods)))

  (define (highest-rated-food)
    (let* ((max-rating (apply max (hash-keys rating-food)))
           (foods (hash-ref rating-food max-rating '())))
      (car (sort foods string<?))))

  (define (highest-rated-food)
    (let* ((max-rating (apply max (hash-keys rating-food)))
           (foods (hash-ref rating-food max-rating '())))
      (car (sort foods string<?))))

  (define (get-food-rating food)
    (hash-ref food-rating food))

  (define (change-rating food new-rating)
    (let* ((old-rating (hash-ref food-rating food))
           (old-foods (hash-ref rating-food old-rating '()))
           (new-foods (cons food (hash-ref rating-food new-rating '()))))
      (hash-set! food-rating food new-rating)
      (hash-set! rating-food old-rating (remove (lambda (f) (equal? f food)) old-foods))
      (hash-set! rating-food new-rating new-foods)))

  (define (highest-rated-food)
    (let* ((max-rating (apply max (hash-keys rating-food)))
           (foods (hash-ref rating-food max-rating '())))
      (car (sort foods string<?))))

  (define (get-highest-rated-food)
    (highest-rated-food))

  (define (get-food-rating food)
    (hash-ref food-rating food))

  (define (change-rating food new-rating)
    (change-rating food new-rating))

  (define (get-highest-rated-food)
    (highest-rated-food))
)