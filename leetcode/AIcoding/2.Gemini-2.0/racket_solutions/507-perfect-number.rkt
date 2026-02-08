(define (check-perfect-number num)
  (if (<= num 1)
      #f
      (let loop ((i 2) (sum 1))
        (cond
          ((= i num) (= sum num))
          ((> i (sqrt num)) (= sum num))
          ((zero? (modulo num i)) (loop (+ i 1) (+ sum i (/ num i))))
          (else (loop (+ i 1) sum))))))