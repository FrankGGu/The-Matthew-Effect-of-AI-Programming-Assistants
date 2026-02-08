(define (findNAfterKSeconds n k)
  (if (<= k 0)
      n
      (findNAfterKSeconds (+ n 1) (- k 1))))