(define (max-chunks-to-sorted-ii arr)
  (let* ((n (vector-length arr))
         (max-left (make-vector n 0))
         (min-right (make-vector n 0)))

    (when (> n 0)
      ;; Populate max-left array
      (vector-set! max-left 0 (vector-ref arr 0))
      (for ([i (in-range 1 n)])
        (vector-set! max-left i (max (vector-ref max-left (- i 1))
                                     (vector-ref arr i))))

      ;; Populate min-right array
      (vector-set! min-right (- n 1) (vector-ref arr (- n 1)))
      (for ([i (in-range (- n 2) -1 -1)]) ; Iterate from n-2 down to 0
        (vector-set! min-right i (min (vector-ref min-right (+ i 1))
                                     (vector-ref arr i)))))

    (if (= n 0)
        0 ; Handle empty array case
        (let ([chunks 1])
          ;; Count valid split points
          (for ([i (in-range (- n 1))]) ; Iterate from 0 to n-2
            (when (<= (vector-ref max-left i)
                      (vector-ref min-right (+ i 1)))
              (set! chunks (+ chunks 1))))
          chunks))))