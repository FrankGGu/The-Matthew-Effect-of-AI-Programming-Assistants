(define (numWays n k)
  (if (= n 0) 1
      (if (= n 1) k
          (let ((mod 1000000007))
            (let loop ((i 2) (ways (vector 0 0)))
              (if (= i (+ n 1))
                  (vector-ref ways 1)
                  (begin
                    (vector-set! ways 0 (vector-ref ways 1))
                    (vector-set! ways 1 (modulo (+ (* (- k 1) (vector-ref ways 1))
                                                    (* (vector-ref ways 0) (k 1))) mod))
                    (loop (+ i 1) ways))))))))