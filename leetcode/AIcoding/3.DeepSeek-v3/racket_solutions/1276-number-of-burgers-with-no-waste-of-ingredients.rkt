(define/contract (num-of-burgers tomato-slices cheese-slices)
  (-> exact-integer? exact-integer? (listof exact-integer?))
  (let ([jumbo (- (* 2 cheese-slices) (* 0.5 tomato-slices))]
        [small (- (* 0.5 tomato-slices) cheese-slices)])
    (if (and (>= jumbo 0) (>= small 0) (integer? jumbo) (integer? small))
        (list jumbo small)
        '())))