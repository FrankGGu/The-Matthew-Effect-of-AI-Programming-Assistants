(define (custom-sort-string order s)
  (define order-map (foldl (lambda (char acc) (hash-set! acc char #t)) (make-hash) order))
  (define others (filter (lambda (char) (not (hash-has? order-map char))) s))
  (define sorted-s (sort s (lambda (a b) (or (hash-has? order-map a) (and (hash-has? order-map b) #f) (char<? a b)))))
  (string-append (apply string (filter (lambda (char) (hash-has? order-map char)) sorted-s)) (apply string others)))

(custom-sort-string "cba" "abcd") ; example usage