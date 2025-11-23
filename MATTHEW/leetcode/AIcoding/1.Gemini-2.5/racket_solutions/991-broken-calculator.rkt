(define (broken-calculator startValue target)
  (let loop ((current-target target) (ops 0))
    (cond
      ((<= current-target startValue)
       (+ ops (- startValue current-target)))
      ((odd? current-target)
       (loop (+ current-target 1) (+ ops 1)))
      (else
       (loop (/ current-target 2) (+ ops 1))))))