(define (get-maximum-generated n)
  (if (zero? n)
      0
      (let* ((nums (make-vector (+ n 1) 0))
             (max-val 0))
        (vector-set! nums 1 1)
        (set! max-val 1)
        (for ([i (in-range 2 (+ n 1))])
          (if (even? i)
              (begin
                (vector-set! nums i (vector-ref nums (/ i 2)))
                (set! max-val (max max-val (vector-ref nums i))))
              (begin
                (vector-set! nums i (+ (vector-ref nums (/ (- i 1) 2)) (vector-ref nums (+ 1 (/ (- i 1) 2)))))
                (set! max-val (max max-val (vector-ref nums i))))))
        max-val)))