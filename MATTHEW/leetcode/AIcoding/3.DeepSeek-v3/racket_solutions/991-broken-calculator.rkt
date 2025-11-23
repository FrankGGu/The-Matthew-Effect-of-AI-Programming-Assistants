(define (broken-calculator startValue target)
  (let loop ([value target] [steps 0])
    (cond
      [(= value startValue) steps]
      [(< value startValue) (+ steps (- startValue value))]
      [(even? value) (loop (/ value 2) (add1 steps))]
      [else (loop (add1 value) (add1 steps))])))