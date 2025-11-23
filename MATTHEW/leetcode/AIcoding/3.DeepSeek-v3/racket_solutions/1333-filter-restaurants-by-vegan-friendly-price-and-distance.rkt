(define/contract (filter-restaurants restaurants vegan-friendly max-price max-distance)
  (-> (listof (listof exact-integer?)) exact-integer? exact-integer? exact-integer? (listof exact-integer?))
  (define filtered
    (filter (lambda (r)
              (and (or (zero? vegan-friendly) (= (list-ref r 2) vegan-friendly))
                   (<= (list-ref r 3) max-price)
                   (<= (list-ref r 4) max-distance)))
            restaurants))
  (define sorted
    (sort filtered
          (lambda (a b)
            (or (> (list-ref a 1) (list-ref b 1))
                (and (= (list-ref a 1) (list-ref b 1))
                     (> (list-ref a 0) (list-ref b 0)))))))
  (map (lambda (r) (list-ref r 0)) sorted))