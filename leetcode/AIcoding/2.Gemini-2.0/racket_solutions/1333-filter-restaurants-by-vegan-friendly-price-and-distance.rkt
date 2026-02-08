(define (filter-restaurants restaurants vegan-friendly max-price max-distance)
  (sort
   (filter
    (lambda (r)
      (and
       (if (= vegan-friendly 1)
           (= (list-ref r 2) 1)
           #t)
       (<= (list-ref r 3) max-price)
       (<= (list-ref r 4) max-distance)))
    restaurants)
   (lambda (r1 r2)
     (if (= (list-ref r1 1) (list-ref r2 1))
         (> (list-ref r1 0) (list-ref r2 0))
         (> (list-ref r1 1) (list-ref r2 1))))
   #:key identity))