(define (min-operations-to-make-sum-ge-k k)
  (if (= k 1)
      0
      (let loop ((x 1) (min-ops (- k 1)))
        (if (> (* x x) k)
            min-ops
            (let* ((num-elements (quotient (+ k x -1) x))
                   (current-ops (+ (- x 1) (- num-elements 1))))
              (loop (add1 x) (min min-ops current-ops)))))))