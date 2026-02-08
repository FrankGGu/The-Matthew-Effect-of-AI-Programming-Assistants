(define/contract (return-to-boundary-count nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([pos 0]
             [count 0]
             [rest nums])
    (if (null? rest)
        count
        (let ([new-pos (+ pos (car rest))])
          (loop new-pos
                (if (zero? new-pos) (add1 count) count)
                (cdr rest))))))