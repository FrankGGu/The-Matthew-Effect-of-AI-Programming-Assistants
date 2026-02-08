(define/contract (three-sum-closest nums target)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let ([nums (sort nums <)]
        [closest-sum (first nums)])
    (let loop ([i 0]
               [closest closest-sum])
      (if (< i (- (length nums) 2))
          (let ([left (+ i 1)]
                [right (- (length nums) 1)])
            (let inner-loop ([l left]
                             [r right]
                             [closest-inner closest])
              (if (< l r)
                  (let* ([sum (+ (list-ref nums i) (list-ref nums l) (list-ref nums r))]
                         [new-closest (if (< (abs (- sum target)) (abs (- closest-inner target)))
                                         sum
                                         closest-inner)])
                    (cond
                      [(< sum target) (inner-loop (+ l 1) r new-closest)]
                      [(> sum target) (inner-loop l (- r 1) new-closest)]
                      [else sum]))
                  (loop (+ i 1) closest-inner))))
          closest))))