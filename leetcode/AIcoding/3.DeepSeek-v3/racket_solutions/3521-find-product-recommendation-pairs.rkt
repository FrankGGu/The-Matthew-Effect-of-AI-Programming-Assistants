#lang racket

(define/product-recommendations (friendship user-products)
  (define user-product-map (make-hash))
  (for ([(user products) (in-hash user-products)])
    (hash-set! user-product-map user (list->set products)))

  (define recommendations (make-hash))

  (for* ([(user1 products1) (in-hash user-products)]
         [(user2 products2) (in-hash user-products)]
         #:when (and (not (equal? user1 user2))
                     (set-member? (hash-ref friendship user1 (set)) user2)))
    (for ([p1 (in-set products1)]
          #:when (not (set-member? products2 p1)))
      (for ([p2 (in-set products2)]
            #:when (not (set-member? products1 p2)))
        (define key (sort (list p1 p2) <))
        (hash-set! recommendations key #t))))

  (sort (hash-keys recommendations)
        (lambda (a b)
          (if (= (car a) (car b))
              (< (cadr a) (cadr b))
              (< (car a) (car b))))))