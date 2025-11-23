(define (get-maximum-generated n)
  (if (= n 0)
      0
      (let ([nums (make-vector (+ n 1) 0)])
        (vector-set! nums 1 1)
        (let loop ([i 2])
          (if (> i n)
              (apply max (vector->list nums))
              (begin
                (if (even? i)
                    (vector-set! nums i (vector-ref nums (/ i 2)))
                    (vector-set! nums i (+ (vector-ref nums (/ (- i 1) 2)) (vector-ref nums (/ (+ i 1) 2)))))
                )
                (loop (+ i 1)))))))))