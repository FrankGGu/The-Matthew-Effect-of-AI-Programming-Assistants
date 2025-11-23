(define/contract (is-power-of-three n)
  (-> exact-integer? boolean?)
  (and (> n 0) (zero? (modulo (expt 3 (inexact->exact (round (/ (log n) (log 3))))) n))))