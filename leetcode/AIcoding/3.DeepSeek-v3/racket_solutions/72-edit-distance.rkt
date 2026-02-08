(define (minDistance word1 word2)
  (let* ((m (string-length word1))
         (n (string-length word2))
    (cond
      [(= m 0) n]
      [(= n 0) m]
      [else
       (let ((dp (make-vector (+ m 1) (make-vector (+ n 1) 0)))
         (for ([i (in-range (+ m 1))])
           (vector-set! (vector-ref dp i) 0 i))
         (for ([j (in-range (+ n 1))])
           (vector-set! (vector-ref dp 0) j j))
         (for ([i (in-range 1 (+ m 1))])
           (for ([j (in-range 1 (+ n 1))])
             (if (char=? (string-ref word1 (- i 1)) (string-ref word2 (- j 1)))
                 (vector-set! (vector-ref dp i) j (vector-ref (vector-ref dp (- i 1)) (- j 1)))
                 (vector-set! (vector-ref dp i) j (+ 1 (min (vector-ref (vector-ref dp (- i 1)) j)
                                                           (vector-ref (vector-ref dp i) (- j 1))
                                                           (vector-ref (vector-ref dp (- i 1)) (- j 1))))))))
         (vector-ref (vector-ref dp m) n))])))