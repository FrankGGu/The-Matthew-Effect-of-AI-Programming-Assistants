(define (min-difficulty jobDifficulty d)
  (define n (length jobDifficulty))
  (if (> d n)
      -1
      (let ((dp (make-vector (add1 n) (make-vector (add1 d) +inf.0))))
        (vector-set! (vector-ref dp 0) 0 0)
        (for* ((i (range 1 (add1 n)))
               (j (range 1 (add1 d))))
          (let loop ((k i) (max-difficulty 0))
            (cond
              ((= k 0) #void)
              (else
               (let ((max-difficulty (max max-difficulty (list-ref jobDifficulty (sub1 k)))))
                 (vector-set! (vector-ref dp i) j (min (vector-ref (vector-ref dp i) j) (+ max-difficulty (vector-ref (vector-ref dp k) (sub1 j)))))
                 (loop (sub1 k) max-difficulty))))))
        (if (real? (vector-ref (vector-ref dp n) d))
            (inexact->exact (vector-ref (vector-ref dp n) d))
            -1))))