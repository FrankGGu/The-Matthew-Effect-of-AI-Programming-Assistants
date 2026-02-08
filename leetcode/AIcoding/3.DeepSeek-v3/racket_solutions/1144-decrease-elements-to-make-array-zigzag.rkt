(define (moves-to-make-zigzag nums)
  (define (helper start)
    (let loop ([i start] [res 0])
      (if (>= i (length nums))
          res
          (let* ([left (if (> i 0) (list-ref nums (- i 1)) +inf.0)]
                 [right (if (< i (- (length nums) 1)) (list-ref nums (+ i 1)) +inf.0)]
                 [min-neighbor (min left right)]
                 [diff (max 0 (- (list-ref nums i) (- min-neighbor 1)))])
            (loop (+ i 2) (+ res diff)))))))
  (min (helper 0) (helper 1)))