(define (max-distance-to-closest-person seats-list)
  (let* ([seats (list->vector seats-list)]
         [n (vector-length seats)])
    (let-values ([(max-dist last-person-idx first-person-idx)
                  (for/fold ([current-max-dist 0]
                             [current-last-person-idx -1]
                             [current-first-person-idx -1])
                            ([i (in-range n)])
                    (if (= (vector-ref seats i) 1)
                        (if (= current-last-person-idx -1)
                            (values (max current-max-dist i)
                                    i
                                    i)
                            (values (max current-max-dist (floor (/ (- i current-last-person-idx) 2)))
                                    i
                                    current-first-person-idx))
                        (values current-max-dist
                                current-last-person-idx
                                current-first-person-idx)))])
      (max max-dist (- n 1 last-person-idx)))))