(define/contract (find-maximum-elegance items k)
  (-> (listof (listof exact-integer?)) exact-integer? exact-integer?)
  (let* ([sorted-items (sort items > #:key (lambda (x) (first x)))]
         [seen (make-hash)]
         [profit 0]
         [duplicates '()])
    (for ([item (in-list sorted-items)]
          [i (in-range k)])
      (let ([category (second item)])
        (if (hash-has-key? seen category)
            (set! duplicates (cons (first item) duplicates))
            (hash-set! seen category #t))
        (set! profit (+ profit (first item)))))
    (let ([unique-categories (hash-count seen)]
          [max-elegance (+ profit (* unique-categories unique-categories))])
      (for ([item (in-list (drop sorted-items k))]
            [dup (in-list (sort duplicates >))]
            #:break (null? dup))
        (let ([category (second item)])
          (unless (hash-has-key? seen category)
            (hash-set! seen category #t)
            (set! profit (+ (- profit dup) (first item)))
            (set! unique-categories (add1 unique-categories))
            (set! max-elegance (max max-elegance (+ profit (* unique-categories unique-categories))))
            (set! duplicates (cdr duplicates))))
      max-elegance)))