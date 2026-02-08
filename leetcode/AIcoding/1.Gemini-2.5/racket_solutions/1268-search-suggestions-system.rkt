(define (search-suggestions-system products searchWord)
  (define sorted-products (sort products string<?))

  (define (get-suggestions prefix)
    (define matching-products
      (filter (lambda (product) (string-prefix? product prefix))
              sorted-products))
    (take matching-products 3))

  (define search-word-len (string-length searchWord))
  (for/list ([i (in-range 1 (add1 search-word-len))])
    (define current-prefix (substring searchWord 0 i))
    (get-suggestions current-prefix)))