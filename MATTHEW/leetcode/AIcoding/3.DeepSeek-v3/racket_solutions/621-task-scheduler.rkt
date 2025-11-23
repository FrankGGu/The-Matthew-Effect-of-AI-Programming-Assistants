(define/contract (least-interval tasks n)
  (-> (listof char?) exact-integer? exact-integer?)
  (let* ([freqs (make-hash)]
         [max-freq 0]
         [max-count 0])
    (for ([task tasks])
      (let ([count (add1 (hash-ref freqs task 0))])
      (hash-set! freqs task count)
      (cond
        [(> count max-freq) (set! max-freq count)
                            (set! max-count 1)]
        [(= count max-freq) (set! max-count (add1 max-count))]))
    (max (length tasks)
         (+ (* (sub1 max-freq) (add1 n)) max-count))))