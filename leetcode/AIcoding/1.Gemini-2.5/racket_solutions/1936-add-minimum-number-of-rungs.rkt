(define (add-minimum-number-of-rungs rungs dist)
  (for/fold ([total-added 0]
             [current-height 0])
            ([rung-height (in-list rungs)])
    (let ([gap (- rung-height current-height)])
      (if (> gap dist)
          (let ([num-steps (quotient (+ gap dist -1) dist)])
            (values (+ total-added (- num-steps 1))
                    rung-height))
          (values total-added
                  rung-height)))))