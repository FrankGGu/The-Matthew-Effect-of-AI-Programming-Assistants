(define/contract (inventory-management stock)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([counts (make-hash)]
             [min-count +inf.0]
             [result 0]
             [lst stock])
    (if (null? lst)
        result
        (let* ([num (car lst)]
               [new-count (add1 (hash-ref counts num 0))])
          (hash-set! counts num new-count)
          (cond
            [(> new-count min-count) (loop counts min-count result (cdr lst))]
            [(= new-count min-count) (loop counts min-count (min result num) (cdr lst))]
            [else (loop counts new-count num (cdr lst))])))))