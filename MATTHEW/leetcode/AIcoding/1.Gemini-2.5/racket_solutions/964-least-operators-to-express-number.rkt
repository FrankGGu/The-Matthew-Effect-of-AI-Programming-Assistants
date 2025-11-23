(define (least-ops x target)
  (define memo (make-hash))

  (define (solve val)
    (cond
      [(= val 0) 0]
      [(= val x) 0]
      [(< val x)
       (let* ([res1 (- (* 2 val) 1)] ; Cost for val times (x/x) using '+'
              [res2 (* 2 (- x val))]) ; Cost for x - (x-val) times (x/x) using '-'
         (min res1 res2))]
      [else
       (let ([cached-result (hash-ref memo val #f)])
         (if cached-result
             cached-result
             (let ([min-ops +inf.0])
               (let loop ((p 0)
                          (current-power-of-x 1)
                          (cost-p 1)) ; Cost to form x^p (p=0, x^0=1, cost 1 for x/x)
                 (cond
                   [(> current-power-of-x (* target x)) ; Break if current_power_of_x is too large
                    (hash-set! memo val min-ops)
                    min-ops]
                   [else
                    (let* ([q (quotient val current-power-of-x)]
                           [r (remainder val current-power-of-x)])

                      ;; Option 1: q * x^p + r
                      ;; This option is valid only if val >= current-power-of-x (i.e., q > 0)
                      (let ([cost-option1 +inf.0])
                        (when (>= val current-power-of-x)
                          (set! cost-option1
                                (+ (* q cost-p)
                                   (if (> q 0) (- q 1) 0) ; q-1 '+' operators for q terms
                                   (solve r)))))
                      (set! min-ops (min min-ops cost-option1))

                      ;; Option 2: (q+1) * x^p - (x^p - r)
                      (let* ([q-plus-1 (+ q 1)]
                             [cost-option2 (+ (* q-plus-1 cost-p)
                                              (if (> q-plus-1 0) (- q-plus-1 1) 0) ; q '+' operators for q+1 terms
                                              (solve (- (* q-plus-1 current-power-of-x) val))
                                              1)]) ; 1 for the '-' operator
                        (set! min-ops (min min-ops cost-option2)))

                      ;; Prepare for next iteration
                      (let* ([next-p (+ p 1)]
                             [next-current-power-of-x (* current-power-of-x x)]
                             [next-cost-p (if (= p 0) 0 (+ cost-p 1))]) ; x^1 costs 0, then add 1 for each '*'
                        (loop next-p next-current-power-of-x next-cost-p))))))))]))

  (solve target))