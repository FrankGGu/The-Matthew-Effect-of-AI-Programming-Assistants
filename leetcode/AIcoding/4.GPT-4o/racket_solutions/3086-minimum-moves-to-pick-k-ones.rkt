(define (min-moves k nums)
  (define ones (filter (lambda (x) (= x 1)) nums))
  (define n (length ones))
  (if (< n k)
      -1
      (let loop ([i 0] [j (+ k -1)] [min-moves +inf.0])
        (if (>= j n)
            min-moves
            (loop (+ i 1) (+ j 1) (min min-moves (- (list-ref ones j) (if (= i 0) -1 (list-ref ones (- i 1))) 1))))
        ))))

(define (minMoves2 nums k)
  (min-moves k nums))