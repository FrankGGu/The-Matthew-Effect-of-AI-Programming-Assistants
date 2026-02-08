(define (count-numbers-with-non-decreasing-digits n)
  (define (combinations n k)
    (cond
      [(or (< k 0) (> k n)) 0]
      [(or (= k 0) (= k n)) 1]
      [else
       (let* ((k-prime (min k (- n k)))
              (num (for/fold ((acc 1)) ((i (in-range 0 k-prime)))
                     (* acc (- n i))))
              (den (for/fold ((acc 1)) ((i (in-range 1 (+ k-prime 1))))
                     (* acc i))))
         (/ num den))]))

  (let loop ((k 1) (total 1))
    (if (> k n)
        total
        (loop (+ k 1) (+ total (combinations (+ k 8) k))))))