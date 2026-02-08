(define/contract (maximum-total-damage power)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([sorted-power (sort power <)]
         [n (length sorted-power)]
         [dp (make-hash)])
    (define (helper i)
      (cond
        [(>= i n) 0]
        [(hash-has-key? dp i) (hash-ref dp i)]
        [else
         (let* ([current (list-ref sorted-power i)]
                [next-i (let loop ([j (add1 i)])
                          (if (or (>= j n) (> (list-ref sorted-power j) (+ current 2)))
                              j
                              (loop (add1 j))))]
                [take (+ current (helper next-i))]
                [skip (helper (add1 i))])
           (hash-set! dp i (max take skip))
           (hash-ref dp i))]))
    (helper 0)))