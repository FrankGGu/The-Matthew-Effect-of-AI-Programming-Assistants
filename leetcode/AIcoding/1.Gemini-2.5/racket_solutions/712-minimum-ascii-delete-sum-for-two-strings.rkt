(define (minimum-delete-sum s1 s2)
  (let* ((n1 (string-length s1))
         (n2 (string-length s2))
         (dp (make-vector (+ n1 1))))

    (for ((i (in-range (+ n1 1))))
      (vector-set! dp i (make-vector (+ n2 1))))

    (vector-set! (vector-ref dp 0) 0 0)

    (for ((i (in-range 1 (+ n1 1))))
      (vector-set! (vector-ref dp i) 0
                   (+ (vector-ref (vector-ref dp (- i 1)) 0)
                      (char->integer (string-ref s1 (- i 1))))))

    (for ((j (in-range 1 (+ n2 1))))
      (vector-set! (vector-ref dp 0) j
                   (+ (vector-ref (vector-ref dp 0) (- j 1))
                      (char->integer (string-ref s2 (- j 1))))))

    (for ((i (in-range 1 (+ n1 1))))
      (for ((j (in-range 1 (+ n2 1))))
        (let ((char1 (string-ref s1 (- i 1)))
              (char2 (string-ref s2 (- j 1))))
          (if (char=? char1 char2)
              (vector-set! (vector-ref dp i) j (vector-ref (vector-ref dp (- i 1)) (- j 1)))
              (vector-set! (vector-ref dp i) j
                           (min (+ (vector-ref (vector-ref dp (- i 1)) j) (char->integer char1))
                                (+ (vector-ref (vector-ref dp i) (- j 1)) (char->integer char2))))))))

    (vector-ref (vector-ref dp n1) n2)))