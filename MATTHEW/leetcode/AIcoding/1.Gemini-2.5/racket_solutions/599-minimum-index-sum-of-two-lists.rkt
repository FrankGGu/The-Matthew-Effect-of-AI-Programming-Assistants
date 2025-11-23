(define (find-restaurant list1 list2)
  (define map1 (make-hash))
  (for ([item list1] [idx (in-naturals)])
    (hash-set! map1 item idx))

  (define min-sum +inf.0)
  (define result '())

  (for ([item list2] [idx2 (in-naturals)])
    (when (hash-has-key? map1 item)
      (define idx1 (hash-ref map1 item))
      (define current-sum (+ idx1 idx2))
      (cond
        [(< current-sum min-sum)
         (set! min-sum current-sum)
         (set! result (list item))]
        [(= current-sum min-sum)
         (set! result (cons item result))])))
  (reverse result))