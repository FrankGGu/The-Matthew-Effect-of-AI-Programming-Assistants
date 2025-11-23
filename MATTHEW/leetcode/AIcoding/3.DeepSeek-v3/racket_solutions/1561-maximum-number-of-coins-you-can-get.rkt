(define (max-coins piles)
  (let* ([sorted-piles (sort piles >)]
         [n (length piles)]
         [steps (/ n 3)]
         [sum 0])
    (for ([i steps])
      (set! sum (+ sum (list-ref sorted-piles (+ (* 2 i) 1)))))
    sum))