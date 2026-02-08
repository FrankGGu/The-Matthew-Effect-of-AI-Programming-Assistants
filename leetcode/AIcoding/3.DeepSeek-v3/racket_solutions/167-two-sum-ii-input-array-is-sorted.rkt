(define/contract (two-sum numbers target)
  (-> (listof exact-integer?) exact-integer? (listof exact-integer?))
  (let loop ([left 0] [right (- (length numbers) 1)])
    (let ([sum (+ (list-ref numbers left) (list-ref numbers right))])
      (cond
        [(= sum target) (list (+ left 1) (+ right 1))]
        [(< sum target) (loop (+ left 1) right)]
        [else (loop left (- right 1))]))))