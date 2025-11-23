(define (kth-grammar n k)
  (if (= n 1)
      0
      (let ((mid (expt 2 (- n 2))))
        (if (<= k mid)
            (kth-grammar (- n 1) k)
            (- 1 (kth-grammar (- n 1) (- k mid)))))))