(define/contract (people-indexes favorite-companies)
  (-> (listof (listof string?)) (listof exact-integer?))
  (define (subset? a b)
    (for/and ([elem a])
      (member elem b)))
  (define n (length favorite-companies))
  (for/list ([i (in-range n)]
             #:when (for/and ([j (in-range n)]
                              #:unless (= i j))
                      (not (subset? (list-ref favorite-companies i)
                                    (list-ref favorite-companies j)))))
    i))