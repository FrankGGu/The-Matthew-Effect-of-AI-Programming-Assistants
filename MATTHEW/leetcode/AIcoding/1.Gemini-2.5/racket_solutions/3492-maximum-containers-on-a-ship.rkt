(define (maximum-units box-types truck-size)
  (let* ([sorted-boxes (sort box-types (lambda (b1 b2) (> (second b1) (second b2))))])
    (for/fold ([total-units 0]
               [remaining-truck-size truck-size])
              ([box sorted-boxes])
      (if (zero? remaining-truck-size)
          (values total-units 0)
          (let* ([num-boxes (first box)]
                 [units-per-box (second box)]
                 [boxes-to-take (min num-boxes remaining-truck-size)])
            (values (+ total-units (* boxes-to-take units-per-box))
                    (- remaining-truck-size boxes-to-take)))))))