(define (combination-sum candidates target)
  (letrec ([helper (lambda (candidates target current-combination)
                      (cond [(zero? target) (list (list->vector current-combination))]
                            [(negative? target) '()]
                            [else
                             (cond [(empty? candidates) '()]
                                   [else
                                    (append
                                     (helper candidates (- target (car candidates)) (cons (car candidates) current-combination))
                                     (helper (cdr candidates) target current-combination))]))])])
    (map vector->list (remove-duplicates (helper candidates target '())
                                         #:test equal?))))