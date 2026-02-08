(define/contract (two-sum numbers target)
  (-> (listof exact-integer?) exact-integer? (listof exact-integer?))
  (let loop ([left 0] [right (sub1 (length numbers))])
    (let ([sum (+ (list-ref numbers left) (list-ref numbers right))])
      (cond
        [(= sum target) (list (add1 left) (add1 right))]
        [(< sum target) (loop (add1 left) right)]
        [else (loop left (sub1 right))]))))