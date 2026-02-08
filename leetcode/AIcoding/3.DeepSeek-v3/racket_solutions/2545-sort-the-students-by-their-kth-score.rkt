(define/contract (sort-the-students score k)
  (-> (listof (listof exact-integer?)) exact-integer? (listof (listof exact-integer?)))
  (sort score (lambda (a b) (> (list-ref a k) (list-ref b k))))
)