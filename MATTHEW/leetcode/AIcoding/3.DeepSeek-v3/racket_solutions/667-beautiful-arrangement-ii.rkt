(define/contract (construct-array n k)
  (-> exact-integer? exact-integer? (listof exact-integer?))
  (let* ([res (make-vector n 1)]
         [left 1]
         [right n]
         [flag (if (even? k) #f #t)])
    (for ([i (in-range 0 n)])
      (cond
        [flag 
         (vector-set! res i left)
         (set! left (add1 left))]
        [else
         (vector-set! res i right)
         (set! right (sub1 right))])
      (when (and (> k 1) (or (< i (sub1 n)) (> k 1)))
        (set! flag (not flag))
        (set! k (sub1 k))))
    (vector->list res)))