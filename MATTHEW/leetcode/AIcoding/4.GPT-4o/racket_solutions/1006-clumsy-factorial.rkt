(define (clumsy n)
  (define (helper x)
    (cond
      [(= x 0) 0]
      [(= x 1) 1]
      [(= x 2) 2]
      [(= x 3) 6]
      [else (let loop ([k x] [total 1] [op 0])
              (cond
                [(= k 0) total]
                [(= op 0) (loop (- k 1) (* total k) 1)]
                [(= op 1) (loop (- k 1) (/ total k) 2)]
                [(= op 2) (loop (- k 1) (+ total k) 0)])))]))
  (if (<= n 0) 0 (helper n)))