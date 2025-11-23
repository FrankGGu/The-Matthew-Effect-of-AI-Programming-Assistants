(define (delete-and-earn nums)
  (let* ([max-val (if (empty? nums) 0 (apply max nums))]
         [points (make-vector (+ max-val 1) 0)]
         [dp (make-vector (+ max-val 1) 0)])

    (for-each (lambda (num)
                (vector-set! points num (+ (vector-ref points num) num)))
              nums)

    (when (> max-val 0)
      (vector-set! dp 1 (vector-ref points 1)))

    (for ([i (in-range 2 (+ max-val 1))])
      (vector-set! dp i
                   (max (+ (vector-ref points i) (vector-ref dp (- i 2)))
                        (vector-ref dp (- i 1)))))

    (vector-ref dp max-val)))