(define/contract (find-poisoned-duration time-series duration)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (if (null? time-series)
      0
      (let loop ([prev (car time-series)]
                 [rest (cdr time-series)]
                 [total 0])
        (if (null? rest)
            (+ total duration)
            (let ([current (car rest)])
              (if (< (- current prev) duration)
                  (loop current (cdr rest) (+ total (- current prev)))
                  (loop current (cdr rest) (+ total duration))))))))