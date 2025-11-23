(define (num-permutations s)
  (define n (string-length s))
  (define dp (make-vector (+ n 1) (make-vector (+ n 1) 0)))
  (for ((i (in-range (+ n 1))))
    (vector-set! (vector-ref dp 0) i 1))
  (for ((i (in-range 1 (+ n 1))))
    (for ((j (in-range i)))
      (cond
        [(char=? (string-ref s (- i 1)) #\I)
         (for ((k (in-range j (+ 1 1))))
           (vector-set! (vector-ref dp i) j
                        (modulo (+ (vector-ref (vector-ref dp i) j)
                                   (vector-ref (vector-ref dp (- i 1)) k))
                                 1000000007)))]
        [else
         (for ((k (in-range j (+ 1 1) (+ n 1)))
           (vector-set! (vector-ref dp i) j
                        (modulo (+ (vector-ref (vector-ref dp i) j)
                                   (vector-ref (vector-ref dp (- i 1)) k))
                                 1000000007)))])))
  (let loop ((j (in-range (+ n 1)))
             (acc 0))
    (if (= j (+ n 1))
        acc
        (loop (+ j 1) (modulo (+ acc (vector-ref (vector-ref dp n) j)) 1000000007))))
  )