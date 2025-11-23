(define (minimum-sum-of-mountain-triplets nums-list)
  (let* ([n (length nums-list)]
         [nums (list->vector nums-list)]
         [left-min (make-vector n)]
         [right-min (make-vector n)]
         [inf +inf.0]
         [min-total-sum inf])

    (vector-set! left-min 0 (vector-ref nums 0))
    (for ([i (in-range 1 n)])
      (vector-set! left-min i (min (vector-ref left-min (- i 1)) (vector-ref nums i))))

    (vector-set! right-min (- n 1) (vector-ref nums (- n 1)))
    (for ([i (in-range (- n 2) -1 -1)])
      (vector-set! right-min i (min (vector-ref right-min (+ i 1)) (vector-ref nums i))))

    (for ([j (in-range 1 (- n 1))])
      (let* ([num-j (vector-ref nums j)]
             [min-i (vector-ref left-min (- j 1))]
             [min-k (vector-ref right-min (+ j 1))])
        (when (and (< min-i num-j) (< min-k num-j))
          (set! min-total-sum (min min-total-sum (+ min-i num-j min-k))))))

    (if (= min-total-sum inf)
        -1
        min-total-sum)))