(define (sum-of-values-at-indices-with-k-set-bits nums k)
  (define (count-set-bits n)
    (let loop ((num n) (count 0))
      (if (zero? num)
          count
          (loop (arithmetic-shift num -1) (+ count (bitwise-and num 1))))))

  (let loop ((idx 0) (current-list nums) (total-sum 0))
    (if (null? current-list)
        total-sum
        (let ((current-val (car current-list)))
          (if (= (count-set-bits idx) k)
              (loop (+ idx 1) (cdr current-list) (+ total-sum current-val))
              (loop (+ idx 1) (cdr current-list) total-sum))))))