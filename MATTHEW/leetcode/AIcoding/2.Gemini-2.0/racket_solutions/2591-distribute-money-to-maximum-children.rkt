(define (distMoney money children)
  (cond
    [(< money children) 0]
    [(< children 1) 0]
    [(= children 1) (if (>= money 8) 1 0)]
    [(>= money (* children 8)) (if (= children (- money (* children 8)) 1) (- children 1) children)]
    [else
     (let* ([give-eight (min children (quotient money 8))]
            [remaining-money (- money (* give-eight 8))]
            [remaining-children (- children give-eight)])
       (cond
         [(and (= remaining-children 1) (= remaining-money 4)) (- give-eight 1)]
         [else give-eight]))]))