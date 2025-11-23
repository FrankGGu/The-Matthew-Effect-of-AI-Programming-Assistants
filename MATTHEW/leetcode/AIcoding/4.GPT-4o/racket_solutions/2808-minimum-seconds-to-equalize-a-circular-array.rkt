(define (minimumSeconds(nums))
  (define n (length nums))
  (define (next-index i)
    (modulo (+ i 1) n))
  (define (get-distance i j)
    (if (< j i)
        (+ n (- i j))
        (- j i)))
  (define max-distance (make-vector n 0))

  (for ((i (in-range n)))
    (let loop ((j (next-index i)) (d 1))
      (when (not (= (vector-ref max-distance i) n))
        (when (= (vector-ref nums i) (vector-ref nums j))
          (vector-set! max-distance i (min (vector-ref max-distance i) d)))
        (loop (next-index j) (+ d 1)))))

  (define min-seconds (apply max (vector->list max-distance)))
  (if (= min-seconds n)
      -1
      min-seconds))

(define (minimumSecondsToEqualizeCircularArray nums)
  (minimumSeconds nums))