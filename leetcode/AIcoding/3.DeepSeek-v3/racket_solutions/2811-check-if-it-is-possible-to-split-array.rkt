(define (can-split-array nums m)
  (let ((n (length nums)))
    (if (<= n 2)
        #t
        (let loop ((i 1))
          (if (>= i n)
              #f
              (if (>= (+ (list-ref nums (- i 1)) (list-ref nums i)) m)
                  (or (can-split-array (take nums i) m)
                      (can-split-array (drop nums i) m))
                  (loop (+ i 1))))))))