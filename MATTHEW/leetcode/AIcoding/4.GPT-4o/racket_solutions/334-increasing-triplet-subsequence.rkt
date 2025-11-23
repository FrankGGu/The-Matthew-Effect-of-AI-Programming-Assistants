(define (increasingTriplet nums)
  (define first +inf.0)
  (define second +inf.0)
  (for ([num nums])
    (cond
      [(< num first) (set! first num)]
      [(and (> num first) (< num second)) (set! second num)]
      [(> num second) (return #t)]))
  #f)