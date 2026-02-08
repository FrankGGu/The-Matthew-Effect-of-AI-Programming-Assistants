(define (lastRemaining n m)
  (let loop ((i 1) (result 0))
    (if (> i n)
        result
        (loop (+ i 1) (modulo (+ result m) i)))))