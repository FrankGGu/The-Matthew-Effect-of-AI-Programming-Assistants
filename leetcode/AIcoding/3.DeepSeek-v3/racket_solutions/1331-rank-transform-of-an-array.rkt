(define/contract (array-rank-transform arr)
  (-> (listof exact-integer?) (listof exact-integer?))
  (let* ([sorted (sort arr <)]
         [rank-hash (make-hash)]
         [rank 1])
    (for ([num (in-list sorted)]
          [i (in-naturals 1)])
      (when (or (= i 1) (not (= num (list-ref sorted (- i 2))))
        (hash-set! rank-hash num rank)
        (set! rank (add1 rank)))
    (map (lambda (x) (hash-ref rank-hash x)) arr)))