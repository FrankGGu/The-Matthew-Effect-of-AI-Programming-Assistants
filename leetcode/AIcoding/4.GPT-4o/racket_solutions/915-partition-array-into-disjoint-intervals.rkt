(define (partition-array nums)
  (define n (length nums))
  (define left-max (make-vector n 0))
  (define right-min (make-vector n 0))

  (vector-set! left-max 0 (vector-ref nums 0))
  (for ((i (in-range 1 n)))
    (vector-set! left-max i (max (vector-ref left-max (- i 1)) (vector-ref nums i))))

  (vector-set! right-min (- n 1) (vector-ref nums (- n 1)))
  (for ((i (in-range (- n 2) -1 -1)))
    (vector-set! right-min i (min (vector-ref right-min (+ i 1)) (vector-ref nums i))))

  (for ((i (in-range (- n 1))))
    (if (<= (vector-ref left-max i) (vector-ref right-min (+ i 1)))
        (return (+ i 1)))))

(partition-array nums)