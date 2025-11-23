(define (isInterleave s1 s2 s3)
  (define n (string-length s1))
  (define m (string-length s2))
  (define o (string-length s3))
  (if (not (= (+ n m) o))
      #f
      (define dp (make-vector (+ 1 n) (make-vector (+ 1 m) #f)))
      (vector-set! dp 0 0 #t)
      (for ([i (in-range (+ 1 n))])
        (for ([j (in-range (+ 1 m))])
          (cond
            [(and (zero? i) (zero? j)) (vector-set! (vector-ref dp 0) j #t)]
            [(zero? i) (vector-set! (vector-ref dp i) j (and (char=? (string-ref s2 (sub1 j)) (string-ref s3 (sub1 j)))) (vector-ref (vector-ref dp 0) j))]
            [(zero? j) (vector-set! (vector-ref dp i) j (and (char=? (string-ref s1 (sub1 i)) (string-ref s3 (sub1 i)))) (vector-ref (vector-ref dp (sub1 i)) j))]
            [else
              (let ([c1 (char=? (string-ref s1 (sub1 i)) (string-ref s3 (sub1 (+ i j))))])
                (let ([c2 (char=? (string-ref s2 (sub1 j)) (string-ref s3 (sub1 (+ i j))))])
                  (vector-set! (vector-ref dp i) j (or (and c1 (vector-ref (vector-ref dp (sub1 i)) j)) (and c2 (vector-ref (vector-ref dp i) (sub1 j)))))))))))
      (vector-ref (vector-ref dp n) m)))