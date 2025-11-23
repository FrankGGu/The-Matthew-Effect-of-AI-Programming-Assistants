(define (buy-candies prices)
  (let ((sorted (sort prices <)))
    (let loop ((i 0) (total 0))
      (if (>= i (length sorted))
          total
          (loop (+ i 3) (+ total (list-ref sorted i)))))))