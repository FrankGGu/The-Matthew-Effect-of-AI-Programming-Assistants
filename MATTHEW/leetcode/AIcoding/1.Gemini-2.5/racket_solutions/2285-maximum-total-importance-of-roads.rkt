(define (maximum-total-importance n roads)
  (define degrees (make-vector n 0))

  (for-each
   (lambda (road)
     (define u (car road))
     (define v (cadr road))
     (vector-set! degrees u (+ (vector-ref degrees u) 1))
     (vector-set! degrees v (+ (vector-ref degrees v) 1)))
   roads)

  (define sorted-degrees (sort (vector->list degrees) <))

  (define total-importance 0)
  (define current-importance 1)

  (for-each
   (lambda (degree-val)
     (set! total-importance (+ total-importance (* degree-val current-importance)))
     (set! current-importance (+ current-importance 1)))
   sorted-degrees)

  total-importance)