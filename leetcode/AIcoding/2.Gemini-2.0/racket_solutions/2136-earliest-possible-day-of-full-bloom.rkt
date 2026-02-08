(define (earliest-full-bloom plant-time grow-time)
  (define n (length plant-time))
  (define plants (make-vector n))
  (for ([i (in-range n)])
    (vector-set! plants i (cons (vector-ref grow-time i) (vector-ref plant-time i)))))
  (define sorted-plants (sort plants > #:key car))
  (define (calculate-bloom-time current-time plants)
    (if (empty? plants)
        current-time
        (let* ([plant (car plants)]
               [grow-time (car plant)]
               [plant-time (cdr plant)]
               [new-time (+ current-time plant-time)]
               [bloom-time (+ new-time grow-time)])
          (calculate-bloom-time new-time (cdr plants)))))
  (calculate-bloom-time 0 (vector->list sorted-plants)))