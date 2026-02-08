(define (maximum-deletions s)
  (let* ([n (string-length s)]
         [dp (make-vector (add1 n) 0)])
    (for ([i (in-range (sub1 n) -1 -1)])
      (for ([j (in-range 1 (add1 (- n i)))]
        (when (and (<= (+ i j) n)
                   (string=? (substring s i (+ i j)) (substring s (+ i j) (+ i j j))))
          (vector-set! dp i (max (vector-ref dp i) (+ 1 (vector-ref dp (+ i j)))))))
      (vector-set! dp i (max (vector-ref dp i) 1)))
    (vector-ref dp 0)))