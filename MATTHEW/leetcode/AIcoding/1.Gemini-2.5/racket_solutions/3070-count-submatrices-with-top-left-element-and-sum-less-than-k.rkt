#lang racket

(define (count-submatrices grid k)
  (define m (vector-length grid))
  (define n (vector-length (vector-ref grid 0)))

  (define prefix-sum (make-vector m #f)) ; Initialize with placeholders

  (for ([i (in-range m)])
    (vector-set! prefix-sum i (make-vector n 0))) ; Fill with vectors of zeros

  (define count 0)

  (for ([r (in-range m)])
    (for ([c (in-range n)])
      (define current-val (vector-ref (vector-ref grid r) c))
      (define sub-sum current-val)

      ; Add value from the cell above
      (when (> r 0)
        (set! sub-sum (+ sub-sum (vector-ref (vector-ref prefix-sum (- r 1)) c))))

      ; Add value from the cell to the left
      (when (> c 0)
        (set! sub-sum (+ sub-sum (vector-ref (vector-ref prefix-sum r) (- c 1)))))

      ; Subtract the value from the top-left diagonal to avoid double counting
      (when (and (> r 0) (> c 0))
        (set! sub-sum (- sub-sum (vector-ref (vector-ref prefix-sum (- r 1)) (- c 1)))))

      ; Store the calculated prefix sum
      (vector-set! (vector-ref prefix-sum r) c sub-sum)

      ; Check if the current submatrix sum is less than or equal to k
      (when (<= sub-sum k)
        (set! count (+ count 1)))))

  count)