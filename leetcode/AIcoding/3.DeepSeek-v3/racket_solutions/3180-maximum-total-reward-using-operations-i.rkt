(define/contract (max-total-reward reward-array)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([rewards (list->vector (sort reward-array <))]
         [n (vector-length rewards)]
         [max-reward (vector-ref rewards (sub1 n))])
    (let loop ([i 0] [total 0])
      (if (>= i n)
          total
          (let ([current (vector-ref rewards i)])
            (if (< total current)
                (loop (add1 i) (+ total current))
                (loop (add1 i) total)))))))