(define/contract (distribute-candies candyType)
  (-> (listof exact-integer?) exact-integer?)
  (let ([unique (set-count (list->set candyType))]
        [total (/ (length candyType) 2)])
    (min unique total)))