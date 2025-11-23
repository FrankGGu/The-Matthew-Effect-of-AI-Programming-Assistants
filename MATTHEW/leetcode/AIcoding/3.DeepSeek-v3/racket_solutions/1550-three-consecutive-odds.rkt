(define (three-consecutive-odds arr)
  (let loop ([i 0] [count 0])
    (cond
      [(>= i (vector-length arr)) #f]
      [(odd? (vector-ref arr i)) 
       (if (>= (add1 count) 3)
           #t
           (loop (add1 i) (add1 count)))]
      [else (loop (add1 i) 0)])))