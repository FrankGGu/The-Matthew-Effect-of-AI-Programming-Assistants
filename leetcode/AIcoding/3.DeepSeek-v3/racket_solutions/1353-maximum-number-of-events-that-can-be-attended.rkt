(define/contract (max-events events)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (let* ([sorted-events (sort events (lambda (a b) (< (car a) (car b))))]
         [heap (make-heap (lambda (a b) (< a b)))]
         [day 1]
         [res 0]
         [n (length sorted-events)]
         [i 0])
    (while (or (< i n) (not (heap-empty? heap)))
      (while (and (< i n) (= (car (list-ref sorted-events i)) day))
        (heap-add! heap (cadr (list-ref sorted-events i)))
        (set! i (add1 i)))
      (while (and (not (heap-empty? heap)) (< (heap-min heap) day))
        (heap-remove-min! heap)))
      (unless (heap-empty? heap)
        (heap-remove-min! heap))
        (set! res (add1 res)))
      (set! day (add1 day)))
    res))