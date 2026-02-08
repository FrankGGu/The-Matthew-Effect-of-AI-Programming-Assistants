(define/contract (custom-sort-string order s)
  (-> string? string? string?)
  (define order-hash (make-hash))
  (for ([c order]
        [i (in-naturals 1)])
    (hash-set! order-hash c i))
  (define (get-order c)
    (hash-ref order-hash c (lambda () 0)))
  (list->string
   (sort (string->list s)
         (lambda (a b) (< (get-order a) (get-order b))))))