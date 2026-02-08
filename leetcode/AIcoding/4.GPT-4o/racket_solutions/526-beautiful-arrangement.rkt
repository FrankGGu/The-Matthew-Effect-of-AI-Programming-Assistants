(define (countArrangement n)
  (define (count i visited)
    (if (= i 1)
        1
        (define (helper j)
          (if (>= j n) 
              0
              (let ((pos (+ j 1)))
                (if (or (not (bitwise-and visited (expt 2 j))) 
                        (not (or (= (modulo i pos) 0) (= (modulo pos i) 0))))
                    (helper (+ j 1))
                    (+ (helper (+ j 1)) (count (sub1 i) (bitwise-ior visited (expt 2 j))))))))
        (helper 0)))
  (count n 0))