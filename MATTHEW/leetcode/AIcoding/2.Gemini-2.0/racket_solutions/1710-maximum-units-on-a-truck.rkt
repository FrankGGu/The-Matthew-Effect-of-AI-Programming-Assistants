(define (maximum-units truck-size box-types)
  (let* ([sorted-box-types (sort box-types > #:key second)]
         [units 0])
    (for ([box-type (in-list sorted-box-types)])
      (let* ([num-boxes (first box-type)]
             [units-per-box (second box-type)])
        (cond
          [(>= truck-size num-boxes)
           (set! units (+ units (* num-boxes units-per-box)))
           (set! truck-size (- truck-size num-boxes))]
          [else
           (set! units (+ units (* truck-size units-per-box)))
           (set! truck-size 0)])))
    units))