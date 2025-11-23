(define/contract (max-sum-after-partitioning arr k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let* ([n (length arr)]
         [dp (make-vector (add1 n) 0)])
    (for ([i (in-range 1 (add1 n))])
      (let ([current-max 0]
            [max-sum 0])
        (for ([j (in-range 1 (add1 (min k i)))])
          (set! current-max (max current-max (list-ref arr (- i j))))
          (set! max-sum (max max-sum (+ (vector-ref dp (- i j)) (* current-max j))))
        (vector-set! dp i max-sum)))
    (vector-ref dp n)))