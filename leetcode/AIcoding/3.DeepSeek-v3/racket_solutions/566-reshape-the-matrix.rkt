(define/contract (matrix-reshape mat r c)
  (-> (listof (listof exact-integer?)) exact-integer? exact-integer? (listof (listof exact-integer?)))
  (let* ([m (length mat)]
         [n (length (car mat))]
         [total (* m n)])
    (if (not (= total (* r c)))
        mat
        (let ([flat (apply append mat)])
          (for/list ([i (in-range r)])
            (for/list ([j (in-range c)])
              (list-ref flat (+ (* i c) j)))))))