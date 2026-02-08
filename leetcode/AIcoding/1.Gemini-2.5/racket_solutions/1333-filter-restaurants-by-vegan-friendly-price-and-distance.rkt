(define (filter-restaurants restaurants veganFriendly maxPrice maxDistance)
  (let* ([filtered-list
          (filter (lambda (r)
                    (and (<= (list-ref r 3) maxPrice)
                         (<= (list-ref r 4) maxDistance)
                         (or (= veganFriendly 0)
                             (= (list-ref r 2) 1))))
                  restaurants)]
         [sorted-list
          (sort filtered-list
                (lambda (r1 r2)
                  (let ([rating1 (list-ref r1 1)]
                        [rating2 (list-ref r2 1)]
                        [id1 (list-ref r1 0)]
                        [id2 (list-ref r2 0)])
                    (or (> rating1 rating2)
                        (and (= rating1 rating2)
                             (> id1 id2))))))])
    (map (lambda (r) (list-ref r 0)) sorted-list)))