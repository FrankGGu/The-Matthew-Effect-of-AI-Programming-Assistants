(define (find-length a b)
  (let* ([n (length a)]
         [m (length b)]
         [dp (make-vector (+ n 1) (make-vector (+ m 1) 0))]
         [max-len 0])
    (for* ([i (in-range 1 (+ n 1))]
           [j (in-range 1 (+ m 1))])
      (if (equal? (list-ref a (- i 1)) (list-ref b (- j 1)))
          (begin
            (vector-set! (vector-ref dp i) j (+ 1 (vector-ref (vector-ref dp (- i 1)) (- j 1))))
            (set! max-len (max max-len (vector-ref (vector-ref dp i) j)))))
      )
    max-len))