(define/contract (maximum-unique-subarray nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([left 0] [right 0] [sum 0] [max-sum 0] [seen (hash)])
    (if (>= right (length nums))
        max-sum
        (let ([num (list-ref nums right)])
          (if (hash-has-key? seen num)
              (let ([new-left (max left (add1 (hash-ref seen num)))])
                (loop new-left
                      (add1 right)
                      (- sum (apply + (take (drop nums left) (- new-left left))))
                      max-sum
                      (hash-remove seen num)))
              (let ([new-sum (+ sum num)]
                    [new-seen (hash-set seen num right)])
                (loop left
                      (add1 right)
                      new-sum
                      (max max-sum new-sum)
                      new-seen)))))))