(define (is-match s p)
  (let* ([s-len (string-length s)]
         [p-len (string-length p)]
         [dp (make-vector (+ s-len 1))])

    (for ([i (in-range (+ s-len 1))])
      (vector-set! dp i (make-vector (+ p-len 1) #f)))

    (vector-set! (vector-ref dp 0) 0 #t)

    (for ([j (in-range 1 (+ p-len 1))])
      (when (char=? (string-ref p (sub1 j)) #\*)
        (vector-set! (vector-ref dp 0) j (vector-ref (vector-ref dp 0) (sub1 j)))))

    (for ([i (in-range 1 (+ s-len 1))])
      (for ([j (in-range 1 (+ p-len 1))])
        (let ([s-char (string-ref s (sub1 i))]
              [p-char (string-ref p (sub1 j))])
          (cond
            [(char=? p-char #\?)
             (vector-set! (vector-ref dp i) j (vector-ref (vector-ref dp (sub1 i)) (sub1 j)))]
            [(char=? p-char #\*)
             (vector-set! (vector-ref dp i) j
                          (or (vector-ref (vector-ref dp (sub1 i)) j)
                              (vector-ref (vector-ref dp i) (sub1 j))))]
            [else
             (when (char=? s-char p-char)
               (vector-set! (vector-ref dp i) j (vector-ref (vector-ref dp (sub1 i)) (sub1 j))))]))))

    (vector-ref (vector-ref dp s-len) p-len)))