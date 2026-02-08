(define (broken-calc startValue target)
  (cond
    [(equal? startValue target) 0]
    [(< startValue target)
     (let loop ([current target] [count 0])
       (cond
         [(< current startValue) (+ count (- startValue current))]
         [(equal? current startValue) count]
         [(even? current) (loop (/ current 2) (+ count 1))]
         [else (loop (+ current 1) (+ count 1))]))]
    [else (- startValue target)]))