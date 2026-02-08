(define (min-distance word1 word2)
  (let* ((m (string-length word1))
         (n (string-length word2))
         (dp (make-vector (add1 m) (make-vector (add1 n) 0))))
    (for ([i (in-range (add1 m))])
      (for ([j (in-range (add1 n))])
        (cond
          [(or (zero? i) (zero? j)) 
           (vector-set! (vector-ref dp i) j (+ i j))]
          [(char=? (string-ref word1 (sub1 i)) (string-ref word2 (sub1 j)))
           (vector-set! (vector-ref dp i) j (vector-ref (vector-ref dp (sub1 i)) (sub1 j)))]
          [else
           (vector-set! (vector-ref dp i) j (add1 (min (vector-ref (vector-ref dp (sub1 i)) j)
                                                      (vector-ref (vector-ref dp i) (sub1 j)))))])))
    (vector-ref (vector-ref dp m) n)))