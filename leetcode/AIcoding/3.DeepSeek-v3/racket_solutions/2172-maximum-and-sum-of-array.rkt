(define (maximum-and-sum nums numSlots)
  (let* ([n (length nums)]
         [m (* 2 numSlots)]
         [dp (make-vector (expt 3 m) -inf.0)]
         [result 0])
    (vector-set! dp 0 0)
    (for ([mask (in-range (expt 3 m))])
      (when (>= (vector-ref dp mask) 0)
      (let ([used (for/sum ([i (in-range m)]) 
                    (quotient (remainder mask (expt 3 (add1 i))) (expt 3 i)))])
        (when (< used n)
          (for ([i (in-range m)])
            (when (< (quotient (remainder mask (expt 3 (add1 i))) (expt 3 i)) 2)
              (let* ([new-mask (+ mask (expt 3 i))]
                     [val (+ (vector-ref dp mask) (bitwise-and (list-ref nums used) (add1 (quotient i 2))))])
                (when (> val (vector-ref dp new-mask))
                  (vector-set! dp new-mask val)
                  (when (> val result)
                    (set! result val)))))))))
    result))