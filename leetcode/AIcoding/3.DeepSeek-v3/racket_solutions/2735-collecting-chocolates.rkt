(define/contract (min-cost nums x)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let loop ([nums nums] [x x] [cost 0] [min-cost +inf.0] [rotations 0])
    (if (> rotations (length nums))
        min-cost
        (let* ([current-cost (+ cost (* rotations x))]
               [new-min (min min-cost current-cost)]
               [shifted-nums (append (rest nums) (list (first nums)))])
          (loop shifted-nums x current-cost new-min (add1 rotations))))))