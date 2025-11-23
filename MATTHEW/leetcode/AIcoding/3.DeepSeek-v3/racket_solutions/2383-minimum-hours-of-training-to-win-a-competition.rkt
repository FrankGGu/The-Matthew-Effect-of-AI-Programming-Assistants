(define/contract (min-number-of-hours initialEnergy initialExperience energy experience)
  (-> exact-integer? exact-integer? (listof exact-integer?) (listof exact-integer?) exact-integer?)
  (define (sum lst) (foldl + 0 lst))
  (let* ([total-energy (sum energy)]
         [needed-energy (max 0 (- (+ total-energy 1) initialEnergy))]
         [current-exp initialExperience]
         [needed-exp 0])
    (for ([exp experience] [i (in-naturals)])
      (if (< current-exp exp)
          (let ([diff (- exp current-exp)])
            (set! needed-exp (+ needed-exp diff 1))
            (set! current-exp (+ current-exp diff 1 exp)))
          (set! current-exp (+ current-exp exp))))
    (+ needed-energy needed-exp)))