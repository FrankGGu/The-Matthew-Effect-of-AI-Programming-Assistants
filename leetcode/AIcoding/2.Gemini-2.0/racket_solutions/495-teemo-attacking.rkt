(define (find-poisoned-duration time-series duration)
  (cond [(empty? time-series) 0]
        [(empty? (rest time-series)) duration]
        [else (+ (min duration (- (second time-series) (first time-series)))
                 (find-poisoned-duration (rest time-series) duration))]))