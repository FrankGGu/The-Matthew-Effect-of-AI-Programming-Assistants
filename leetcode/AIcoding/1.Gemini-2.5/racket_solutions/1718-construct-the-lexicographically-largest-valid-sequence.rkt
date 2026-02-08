(define (construct-lexicographically-largest-valid-sequence n)
  (define len (- (* 2 n) 1))
  (define result-vec (make-vector len 0))
  (define placed-counts (make-vector (+ n 1) 0))

  (define (backtrack idx)
    (cond
      ((= idx len)
       (vector->list result-vec))

      ((not (= (vector-ref result-vec idx) 0))
       (backtrack (+ idx 1)))

      (else
       (let loop ((num n))
         (cond
           ((< num 1) #f)

           ((= num n)
            (if (= (vector-ref placed-counts n) 0)
                (begin
                  (vector-set! result-vec idx n)
                  (vector-set! placed-counts n 1)
                  (let ((res (backtrack (+ idx 1))))
                    (if res
                        res
                        (begin
                          (vector-set! result-vec idx 0)
                          (vector-set! placed-counts n 0)
                          (loop (- num 1))))))
                (loop (- num 1))))

           (else
            (let ((second-idx (+ idx num 1)))
              (if (and (< (vector-ref placed-counts num) 2)
                       (< second-idx len)
                       (= (vector-ref result-vec second-idx) 0))
                  (begin
                    (vector-set! result-vec idx num)
                    (vector-set! result-vec second-idx num)
                    (vector-set! placed-counts num (+ (vector-ref placed-counts num) 2))
                    (let ((res (backtrack (+ idx 1))))
                      (if res
                          res
                          (begin
                            (vector-set! result-vec idx 0)
                            (vector-set! result-vec second-idx 0)
                            (vector-set! placed-counts num (- (vector-ref placed-counts num) 2))
                            (loop (- num 1))))))
                  (loop (- num 1))))))))))

  (backtrack 0))