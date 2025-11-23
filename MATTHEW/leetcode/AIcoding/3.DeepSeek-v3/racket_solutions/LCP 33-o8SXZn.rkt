(define/contract (store-water bucket-capacity initial-water operations)
  (-> (listof exact-integer?) (listof exact-integer?) (listof exact-integer?) exact-integer?)
  (let loop ([buckets bucket-capacity]
             [waters initial-water]
             [ops operations]
             [steps 0])
    (if (null? ops)
        steps
        (let* ([op (car ops)]
               [i (car op)]
               [j (cadr op)]
               [current-water (list-ref waters i)]
               [target-water (list-ref waters j)]
               [b-cap (list-ref buckets j)]
               [transfer (min current-water (- b-cap target-water))])
          (if (zero? transfer)
              (loop buckets waters (cdr ops) (add1 steps))
              (loop buckets
                    (list-set (list-set waters i (- current-water transfer))
                              j (+ target-water transfer))
                    (cdr ops)
                    (add1 steps)))))))