(define (find-product-recommendation-pairs products)
  (let* ((product-map (make-hash))
         (result '()))
    (for ([product products])
      (let ([user (first product)]
            [item (second product)])
        (hash-update! product-map user
                       (lambda (items) (cons item items))
                       (list item))))
    (for ([user1 (hash-keys product-map)])
      (for ([user2 (hash-keys product-map)])
        (when (< (string->number user1) (string->number user2))
          (let* ([items1 (hash-ref product-map user1)]
                 [items2 (hash-ref product-map user2)]
                 [common-items (length (intersect items1 items2))])
            (when (>= common-items 2)
              (set! result (cons (list user1 user2 common-items) result)))))))
    (sort result (lambda (a b)
                    (cond [(< (string->number (first a)) (string->number (first b))) #t]
                          [(> (string->number (first a)) (string->number (first b))) #f]
                          [(< (string->number (second a)) (string->number (second b))) #t]
                          [else #f])))))