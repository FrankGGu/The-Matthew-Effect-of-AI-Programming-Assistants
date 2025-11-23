(define/contract (dist-money money children)
  (-> exact-integer? exact-integer? exact-integer?)
  (if (or (< money children) (and (= children 1) (= money 4)))
      0
      (let* ([remaining (- money children)]
             [max8 (quotient remaining 7)]
             [leftover (remainder remaining 7)])
        (cond
          [(< remaining 0) -1]
          [(= leftover 3)
           (if (and (= max8 (- children 1)) (> children 1))
               (- max8 1)
               max8)]
          [(> max8 children) (- children 1)]
          [(and (= leftover 0) (= max8 children)) max8]
          [else max8])))