(define (smallest-missing-non-negative-integer-after-operations nums value)
  (let* ([n (length nums)]
         [counts (make-vector value 0)])
    (for ([num nums])
      (vector-set! counts (modulo num value) (+ 1 (vector-ref counts (modulo num value)))))
    (let loop ([i 0])
      (let ([index (modulo i value)])
        (if (> (vector-ref counts index) 0)
            (begin
              (vector-set! counts index (- (vector-ref counts index) 1))
              (loop (+ i 1)))
            i)))))