(define (get-maximum-generated n)
  (cond
    ((= n 0) 0)
    ((= n 1) 1)
    (else
     (let* ((nums (make-vector (+ n 1)))
            (max-val 0))
       (vector-set! nums 0 0)
       (vector-set! nums 1 1)
       (set! max-val 1)

       (for ([i (in-range 1 (add1 (quotient n 2)))])
         (let* ((idx-2i (* 2 i))
                (idx-2i+1 (+ (* 2 i) 1)))

           (when (<= idx-2i n)
             (let ((val-2i (vector-ref nums i)))
               (vector-set! nums idx-2i val-2i)
               (when (> val-2i max-val)
                 (set! max-val val-2i))))

           (when (<= idx-2i+1 n)
             (let ((val-2i+1 (+ (vector-ref nums i) (vector-ref nums (+ i 1)))))
               (vector-set! nums idx-2i+1 val-2i+1)
               (when (> val-2i+1 max-val)
                 (set! max-val val-2i+1))))))
       max-val))))