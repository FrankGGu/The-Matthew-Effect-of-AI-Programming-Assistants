(define (minCostII costs m n)
  (if (or (= m 0) (= n 0)) 0
      (let loop ((i 0) (dp (make-vector m 0)))
        (if (< i m)
            (begin
              (vector-set! dp i (if (= n 1) (if (= (vector-ref costs i 0) 0) (car (vector-ref costs i)) 0) (apply min (vector-ref costs i))))
              (loop (+ i 1) dp))
            (let loop2 ((j 0) (total 0))
              (if (< j m)
                  (begin
                    (set! total (+ total (if (= n 1) 0 (vector-ref dp j))))
                    (loop2 (+ j 1) total))
                  total))))))

(define (paintHouseIV costs)
  (let ((m (vector-length costs))
        (n (if (zero? (vector-length costs)) 0 (vector-length (vector-ref costs 0))))))
    (minCostII costs m n)))