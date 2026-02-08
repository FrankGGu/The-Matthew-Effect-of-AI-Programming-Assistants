(define (array-rank-transform arr)
  (define sorted-unique (sort (remove-duplicates arr) <))
  (define ranks (for/list ([x sorted-unique]) (add1 (index-of sorted-unique x))))
  (for/list ([x arr]) (index-of sorted-unique x)))

(array-rank-transform '(40 10 20 30))