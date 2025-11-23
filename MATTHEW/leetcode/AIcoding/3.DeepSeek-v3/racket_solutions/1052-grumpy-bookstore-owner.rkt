(define/contract (max-satisfied customers grumpy minutes)
  (-> (listof exact-integer?) (listof exact-integer?) exact-integer? exact-integer?)
  (let* ([n (length customers)]
         [total-satisfied (for/sum ([c customers] [g grumpy]) (if (zero? g) c 0))]
         [max-extra 0]
         [current-extra 0])
    (for ([i (in-range n)])
      (when (>= i minutes)
        (let ([left (- i minutes)])
          (when (= (list-ref grumpy left) 1)
            (set! current-extra (- current-extra (list-ref customers left)))))))
      (when (= (list-ref grumpy i) 1)
        (set! current-extra (+ current-extra (list-ref customers i))))
      (when (> current-extra max-extra)
        (set! max-extra current-extra)))
    (+ total-satisfied max-extra)))