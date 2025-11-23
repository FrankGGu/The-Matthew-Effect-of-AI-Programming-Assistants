(define/contract (min-operations-max-profit customers boardingCost runningCost)
  (-> (listof exact-integer?) exact-integer? exact-integer? exact-integer?)
  (let loop ([waiting 0] [profit 0] [max-profit 0] [rotations 0] [best-rotations -1] [i 0])
    (if (and (zero? waiting) (>= i (length customers)))
        (if (> max-profit 0) best-rotations -1)
        (let* ([current (if (< i (length customers)) (list-ref customers i) 0)]
               [total (+ waiting current)]
               [board (min total 4)]
               [new-waiting (- total board)]
               [new-profit (+ profit (- (* board boardingCost) runningCost))]
               [new-rotations (+ rotations 1)]
               [new-best (if (> new-profit max-profit) new-rotations best-rotations)]
               [new-max (max max-profit new-profit)])
          (loop new-waiting new-profit new-max new-rotations new-best (+ i 1))))))