(define/contract (is-interleave s1 s2 s3)
  (-> string? string? string? boolean?)
  (let* ([n1 (string-length s1)]
         [n2 (string-length s2)]
         [n3 (string-length s3)])
    (if (not (= n3 (+ n1 n2)))
        #f
        (let ([dp (make-vector (add1 n1) (make-vector (add1 n2) #f))])
          (vector-set! (vector-ref dp 0) 0 #t)
          (for ([i (in-range (add1 n1))])
            (for ([j (in-range (add1 n2))])
              (when (or (> i 0) (> j 0))
                (let ([c (string-ref s3 (+ (sub1 i) (sub1 j)))]
                      [valid #f])
                  (when (and (> i 0) 
                             (vector-ref (vector-ref dp (sub1 i)) j)
                             (char=? (string-ref s1 (sub1 i)) c))
                    (set! valid #t))
                  (when (and (> j 0) 
                             (vector-ref (vector-ref dp i) (sub1 j))
                             (char=? (string-ref s2 (sub1 j)) c))
                    (set! valid #t))
                  (vector-set! (vector-ref dp i) j valid)))))
          (vector-ref (vector-ref dp n1) n2)))))