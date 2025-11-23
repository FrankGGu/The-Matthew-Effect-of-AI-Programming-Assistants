(define (numWays n)
  (if (= n 0) 1
      (if (= n 1) 1
          (+ (numWays (- n 1)) (numWays (- n 2))))))