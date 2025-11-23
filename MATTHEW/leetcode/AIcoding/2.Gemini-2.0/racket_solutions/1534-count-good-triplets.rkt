(define (count-good-triplets arr a b c)
  (let ((n (length arr)))
    (let loop ((i 0) (count 0))
      (if (= i (- n 2))
          count
          (loop (+ i 1)
                (let loop2 ((j (+ i 1)) (count2 count))
                  (if (= j (- n 1))
                      count2
                      (loop2 (+ j 1)
                             (let loop3 ((k (+ j 1)) (count3 count2))
                               (if (= k n)
                                   count3
                                   (loop3 (+ k 1)
                                          (if (and (<= (abs (- (list-ref arr i) (list-ref arr j))) a)
                                                   (<= (abs (- (list-ref arr j) (list-ref arr k))) b)
                                                   (<= (abs (- (list-ref arr i) (list-ref arr k))) c))
                                              (+ count3 1)
                                              count3)))))))))))))