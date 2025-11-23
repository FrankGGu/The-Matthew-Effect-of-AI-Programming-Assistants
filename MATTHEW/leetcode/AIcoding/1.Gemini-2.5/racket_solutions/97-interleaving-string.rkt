(define (is-interleave s1 s2 s3)
  (let* ((n1 (string-length s1))
         (n2 (string-length s2))
         (n3 (string-length s3)))
    (if (not (= (+ n1 n2) n3))
        #f
        (let* ((dp (make-vector (+ n1 1) #f)))
          (for ((i (in-range (+ n1 1))))
            (vector-set! dp i (make-vector (+ n2 1) #f)))

          (vector-set! (vector-ref dp 0) 0 #t)

          (for ((i (in-range 1 (+ n1 1))))
            (when (and (vector-ref (vector-ref dp (- i 1)) 0)
                       (char=? (string-ref s1 (- i 1)) (string-ref s3 (- i 1))))
              (vector-set! (vector-ref dp i) 0 #t)))

          (for ((j (in-range 1 (+ n2 1))))
            (when (and (vector-ref (vector-ref dp 0) (- j 1))
                       (char=? (string-ref s2 (- j 1)) (string-ref s3 (- j 1))))
              (vector-set! (vector-ref dp 0) j #t)))

          (for ((i (in-range 1 (+ n1 1))))
            (for ((j (in-range 1 (+ n2 1))))
              (let ((char3-idx (+ i j -1)))
                (let ((val-from-s1 (and (vector-ref (vector-ref dp (- i 1)) j)
                                        (char=? (string-ref s1 (- i 1)) (string-ref s3 char3-idx))))
                      (val-from-s2 (and (vector-ref (vector-ref dp i) (- j 1))
                                        (char=? (string-ref s2 (- j 1)) (string-ref s3 char3-idx)))))
                  (vector-set! (vector-ref dp i) j (or val-from-s1 val-from-s2))))))

          (vector-ref (vector-ref dp n1) n2)))))