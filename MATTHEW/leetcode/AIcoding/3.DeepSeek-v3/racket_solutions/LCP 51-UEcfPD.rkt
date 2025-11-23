(define/contract (cook-recipes recipes ingredients supplies)
  (-> (listof string?) (listof (listof string?)) (listof string?) (listof string?))
  (let loop ([supplies (list->set supplies)]
             [result '()]
             [changed? #t])
    (if (not changed?)
        (reverse result)
        (let ([new-supplies supplies]
              [new-result result]
              [new-changed? #f])
          (for ([recipe recipes]
                [ingredient-list ingredients]
            #:when (and (not (set-member? supplies recipe))
                        (for/and ([ing ingredient-list])
                          (set-member? supplies ing)))
            (set! new-supplies (set-add new-supplies recipe))
            (set! new-result (cons recipe new-result))
          (loop new-supplies new-result (not (equal? new-supplies supplies)))))))