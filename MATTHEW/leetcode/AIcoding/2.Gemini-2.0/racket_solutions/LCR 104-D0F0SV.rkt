(define (combination-sum4 nums target)
  (define memo (make-vector (+ target 1) 0))
  (vector-set! memo 0 1)

  (define (solve current-target)
    (cond
      [(= current-target 0) 1]
      [(< current-target 0) 0]
      [else
       (if (> (vector-ref memo current-target) 0)
           (vector-ref memo current-target)
           (begin
             (let ([count (for/sum ([num nums])
                            (solve (- current-target num)))])
               (vector-set! memo current-target count)
               count)))]))

  (solve target))