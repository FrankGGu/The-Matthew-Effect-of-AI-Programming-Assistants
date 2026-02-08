(define/contract (construct-rectangle area)
  (-> exact-integer? (listof exact-integer?))
  (define w (inexact->exact (floor (sqrt area))))
  (let loop ([w w])
    (cond
      [(zero? (modulo area w)) (list (quotient area w) w)]
      [else (loop (sub1 w))])))