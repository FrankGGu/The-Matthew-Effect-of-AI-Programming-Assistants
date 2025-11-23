(define (find-restaurant list1 list2)
  (define rest-map
    (for/hash ([i (in-naturals)] [r (in-list list1)])
      (values r i)))
  (define min-index
    (for/fold ([min 100000]) ([i (in-naturals)] [r (in-list list2)])
      (if (hash-has-key? rest-map r)
          (min min (+ i (hash-ref rest-map r)))
          min)))
  (for/list ([i (in-naturals)] [r (in-list list1)])
    (when (= (+ i (hash-ref rest-map r)) min-index)
      r)))