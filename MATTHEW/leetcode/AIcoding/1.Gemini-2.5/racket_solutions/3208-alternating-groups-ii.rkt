(define (alternating-groups colors k)
  (let* ((n (vector-length colors))
         (extended-colors (make-vector (* 2 n)))
         (diff-array (make-vector (- (* 2 n) 1))))

    (for ((i (in-range n)))
      (vector-set! extended-colors i (vector-ref colors i)))
    (for ((i (in-range n)))
      (vector-set! extended-colors (+ n i) (vector-ref colors i)))

    (for ((i (in-range (- (* 2 n) 1))))
      (vector-set! diff-array i (if (not (= (vector-ref extended-colors i)
                                            (vector-ref extended-colors (+ i 1))))
                                   1
                                   0)))

    (let ((count 0))
      (when (> k 1)
        (let ((current-sum 0))
          (for ((i (in-range (- k 1))))
            (set! current-sum (+ current-sum (vector-ref diff-array i))))

          (when (= current-sum (- k 1))
            (set! count (+ count 1)))

          (for ((j (in-range 1 n)))
            (set! current-sum (- current-sum (vector-ref diff-array (- j 1))))
            (set! current-sum (+ current-sum (vector-ref diff-array (+ j (- k 2)))))
            (when (= current-sum (- k 1))
              (set! count (+ count 1))))))

      (when (= k 1)
        (set! count n))

      count)))