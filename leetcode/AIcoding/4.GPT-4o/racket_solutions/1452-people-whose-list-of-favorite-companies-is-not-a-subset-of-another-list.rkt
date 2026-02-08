(define (people-not-in-subset favorite-companies)
  (define (is-subset? a b)
    (and (not (null? a))
         (null? (filter (lambda (x) (not (member x b))) a))))

  (define (process company-list)
    (filter (lambda (person)
              (not (or (ormap (lambda (other)
                                 (is-subset? (cdr person) (cdr other)))
                           company-list))))
            company-list))

  (process favorite-companies))