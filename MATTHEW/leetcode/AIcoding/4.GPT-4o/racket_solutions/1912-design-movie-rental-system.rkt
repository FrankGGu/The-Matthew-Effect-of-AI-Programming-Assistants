(define MovieRentalSystem
  (class
    ()
    (define/public (initialize n)
      (set! movie-count n)
      (set! rented (make-hash))
      (set! available (make-hash)))

    (define/private (add-movie id)
      (hash-set! available id 1))

    (define/public (rent id)
      (if (hash-has-key? available id)
          (begin
            (hash-set! rented id (+ (hash-ref rented id 0) 1))
            (hash-set! available id (- (hash-ref available id 1) 1))
            (if (= (hash-ref available id 0) 0)
                (hash-remove! available id)))))

    (define/public (return id)
      (if (hash-has-key? rented id)
          (begin
            (hash-set! rented id (- (hash-ref rented id 0) 1))
            (if (> (hash-ref rented id 0) 0)
                (hash-set! rented id (hash-ref rented id 0))
                (hash-remove! rented id))
            (add-movie id))))

    (define/public (get-available)
      (hash->list available))

    (define/public (get-rented)
      (hash->list rented))))