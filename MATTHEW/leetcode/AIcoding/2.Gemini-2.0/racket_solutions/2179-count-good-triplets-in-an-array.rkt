(define (count-good-triplets arr a b c)
  (let ((n (vector-length arr)))
    (let loop ((i 0) (count 0))
      (if (= i (- n 2))
          count
          (loop (+ i 1)
                (let inner-loop ((j (+ i 1)) (current-count count))
                  (if (= j (- n 1))
                      current-count
                      (inner-loop (+ j 1)
                                  (let final-loop ((k (+ j 1)) (final-count current-count))
                                    (if (= k n)
                                        final-count
                                        (final-loop (+ k 1)
                                                    (if (and (<= (abs (- (vector-ref arr i) (vector-ref arr j)) ) a)
                                                             (<= (abs (- (vector-ref arr j) (vector-ref arr k)) ) b)
                                                             (<= (abs (- (vector-ref arr i) (vector-ref arr k)) ) c))
                                                        (+ final-count 1)
                                                        final-count)))))))))))))