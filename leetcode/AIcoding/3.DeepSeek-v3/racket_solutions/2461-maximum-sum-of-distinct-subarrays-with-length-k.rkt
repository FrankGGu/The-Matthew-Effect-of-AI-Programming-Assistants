(define/contract (maximum-subarray-sum nums k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let loop ([left 0] [right 0] [sum 0] [max-sum 0] [seen (hash)])
    (cond
      [(>= right (length nums)) max-sum]
      [(>= (- right left) k)
       (let* ([num-left (list-ref nums left)]
              [new-sum (- sum num-left)]
              [new-seen (hash-remove seen num-left)])
         (loop (add1 left) right new-sum max-sum new-seen))]
      [else
       (let* ([num-right (list-ref nums right)]
              [new-right (add1 right)]
              [new-sum (+ sum num-right)])
         (if (hash-has-key? seen num-right)
             (loop (add1 left) new-right 0 max-sum (hash))
             (let* ([new-seen (hash-set seen num-right #t)]
                    [new-max-sum (if (= (- new-right left) k)
                                    (max max-sum new-sum)
                                    max-sum)])
               (loop left new-right new-sum new-max-sum new-seen))))])))