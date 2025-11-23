(define (remove-elements head val)
  (let loop ([prev #f] [curr head])
    (cond
      [(not curr) #f]
      [(= (car curr) val)
       (loop prev (cdr curr))]
      [else
       (if prev
           (begin
             (set-cdr! prev (cdr curr))
             (loop curr (cdr curr)))
           (begin
             (set-cdr! curr (cdr curr))
             (loop curr (cdr curr))))])))