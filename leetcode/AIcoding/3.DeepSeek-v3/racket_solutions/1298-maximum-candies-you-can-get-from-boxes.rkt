(define/contract (max-candies status candies keys contained-boxes initial-boxes)
  (-> (listof exact-integer?) (listof exact-integer?) (listof (listof exact-integer?)) (listof (listof exact-integer?)) (listof exact-integer?) exact-integer?)
  (let loop ([boxes initial-boxes]
             [my-keys (set)]
             [total 0]
             [visited (set)])
    (if (null? boxes)
        total
        (let* ([box (car boxes)]
               [rest-boxes (cdr boxes)]
               [box-status (list-ref status box)]
               [box-candies (list-ref candies box)]
               [box-keys (list-ref keys box)]
               [box-contained (list-ref contained-boxes box)])
          (cond
            [(or (= box-status 1) (set-member? my-keys box))
             (loop (append rest-boxes box-contained)
                   (set-union my-keys (list->set box-keys))
                   (+ total box-candies)
                   (set-add visited box))]
            [else
             (loop rest-boxes my-keys total visited)])))))