(define (longest-subarray nums)
  (let* ([n (length nums)]
         [inc-dp (make-vector n 1)]
         [dec-dp (make-vector n 1)]
         [max-len 1])
    (for ([i (in-range 1 n)])
      (if (> (list-ref nums i) (list-ref nums (- i 1)))
          (vector-set! inc-dp i (+ (vector-ref inc-dp (- i 1)) 1))
          (vector-set! inc-dp i 1))
      (if (< (list-ref nums i) (list-ref nums (- i 1)))
          (vector-set! dec-dp i (+ (vector-ref dec-dp (- i 1)) 1))
          (vector-set! dec-dp i 1))
      (set! max-len (max max-len (vector-ref inc-dp i) (vector-ref dec-dp i))))
    max-len))