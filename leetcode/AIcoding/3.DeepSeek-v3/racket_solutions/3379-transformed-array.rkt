(define/contract (transform-array arr)
  (-> (listof exact-integer?) (listof exact-integer?))
  (let loop ([lst arr]
             [changed? #f])
    (if (not changed?)
        arr
        (let ([new-lst (for/list ([i (in-range (length lst))])
                         (cond
                           [(or (= i 0) (= i (sub1 (length lst)))) (list-ref lst i)]
                           [(> (list-ref lst i) (list-ref lst (sub1 i))) 
                            (if (> (list-ref lst i) (list-ref lst (add1 i)))
                                (sub1 (list-ref lst i))
                                (list-ref lst i))]
                           [(< (list-ref lst i) (list-ref lst (sub1 i)))
                            (if (< (list-ref lst i) (list-ref lst (add1 i)))
                                (add1 (list-ref lst i))
                                (list-ref lst i))]
                           [else (list-ref lst i)]))])
          (if (equal? lst new-lst)
              lst
              (loop new-lst #t))))))