(define (minimum-initial-energy tasks)
  (let* ([sorted-tasks (sort tasks > #:key (lambda (task) (- (cdr task) (car task))))]
         [result 0]
         [current-energy 0])
    (for ([task sorted-tasks])
      (let ([cost (car task)]
            [minimum (cdr task)])
        (if (< current-energy cost)
            (let ([diff (- cost current-energy)])
              (set! result (+ result diff))
              (set! current-energy (+ current-energy diff)))
            (void))
        (set! current-energy (- current-energy cost))))
    result))