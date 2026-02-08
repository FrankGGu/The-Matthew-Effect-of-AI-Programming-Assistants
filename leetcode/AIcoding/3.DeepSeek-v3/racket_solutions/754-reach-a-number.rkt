(define (reach-number target)
  (let loop ([sum 0] [step 1] [target (abs target)])
    (cond
      [(or (> sum target) (not (= (modulo (- sum target) 2) 0)))
       (loop (+ sum step) (add1 step) target)]
      [else (sub1 step)])))