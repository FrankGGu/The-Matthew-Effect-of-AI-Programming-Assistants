(define (can-reach target)
  (define (helper steps pos)
    (cond [(>= pos target) #t]
          [(>= pos (length steps)) #f]
          [else (helper (vector-set! steps pos #t) (+ pos (vector-ref steps pos)))]))
  (helper (make-vector target #f) 0))