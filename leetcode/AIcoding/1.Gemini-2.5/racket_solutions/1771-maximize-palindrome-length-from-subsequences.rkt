(define (maximize-palindrome-length-from-subsequences word1 word2)
  (let* ([s (string-append word1 word2)]
         [n1 (string-length word1)]
         [n (string-length s)]
         [dp (make-vector n (lambda () (make-vector n 0)))]
         [max-len 0])

    (for ([i (in-range n)])
      (vector-set! (vector-ref dp i) i 1))

    (for ([len (in-range 2 (+ n 1))])
      (for ([i (in-range (- n len) -1)])
        (let ([j (+ i len -1)])
          (if (= (string-ref s i) (string-ref s j))
              (begin
                (if (>= (- j 1) (+ i 1))
                    (vector-set! (vector-ref dp i) j (+ 2 (vector-ref (vector-ref dp (+ i 1)) (- j 1))))
                    (vector-set! (vector-ref dp i) j 2)))
              (vector-set! (vector-ref dp i) j (max (vector-ref (vector-ref dp (+ i 1)) j)
                                                     (vector-ref (vector-ref dp i) (- j 1))))))))

    (for ([i (in-range n1)])
      (for ([j (in-range n1 n)])
        (when (= (string-ref s i) (string-ref s j))
          (let ([inner-lps-len (if (> j (+ i 1))
                                 (vector-ref (vector-ref dp (+ i 1)) (- j 1))
                                 0)])
            (set! max-len (max max-len (+ 2 inner-lps-len)))))))

    max-len))