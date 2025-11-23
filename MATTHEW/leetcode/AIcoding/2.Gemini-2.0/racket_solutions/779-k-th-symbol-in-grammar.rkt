(define (kth-grammar n k)
  (if (= n 1)
      0
      (let ((len (expt 2 (- n 2))))
        (if (<= k len)
            (kth-grammar (- n 1) k)
            (if (= (kth-grammar (- n 1) (- k len)) 0)
                1
                0))))
  )