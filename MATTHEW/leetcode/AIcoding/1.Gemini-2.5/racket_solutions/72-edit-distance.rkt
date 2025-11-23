(define (min-distance word1 word2)
  (let* ((n (string-length word1))
         (m (string-length word2))
         (dp (make-vector (+ n 1) #f)))

    (for ([i (in-range (+ n 1))])
      (vector-set! dp i (make-vector (+ m 1) 0)))

    (for ([i (in-range (+ n 1))])
      (vector-set! (vector-ref dp i) 0 i))

    (for ([j (in-range (+ m 1))])
      (vector-set! (vector-ref dp 0) j j))

    (for ([i (in-range 1 (+ n 1))])
      (for ([j (in-range 1 (+ m 1))])
        (let ((char1 (string-ref word1 (- i 1)))
              (char2 (string-ref word2 (- j 1))))
          (if (char=? char1 char2)
              (vector-set! (vector-ref dp i) j (vector-ref (vector-ref dp (- i 1)) (- j 1)))
              (vector-set! (vector-ref dp i) j
                           (+ 1 (min (vector-ref (vector-ref dp (- i 1)) j)
                                     (vector-ref (vector-ref dp i) (- j 1))
                                     (vector-ref (vector-ref dp (- i 1)) (- j 1)))))))))

    (vector-ref (vector-ref dp n) m)))