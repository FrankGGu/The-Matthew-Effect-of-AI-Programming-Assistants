(define/contract (find-comfortable-humidity current-humidity desired-humidity)
  (-> exact-integer? exact-integer? exact-integer?)
  (let loop ((current current-humidity) (steps 0))
    (cond
      [(= current desired-humidity) steps]
      [(< current desired-humidity)
       (loop (if (even? current)
                 (quotient current 2)
                 (+ current 1))
             (+ steps 1))]
      [else
       (loop (if (even? current)
                 (quotient current 2)
                 (- current 1))
             (+ steps 1))])))