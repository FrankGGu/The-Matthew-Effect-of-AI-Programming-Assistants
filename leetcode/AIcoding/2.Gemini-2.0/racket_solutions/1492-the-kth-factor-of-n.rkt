(define (kth-factor n k)
  (let loop ([i 1] [factors 0])
    (cond
      [(> i n) -1]
      [(= 0 (remainder n i))
       (if (= (+ factors 1) k)
           i
           (loop (+ i 1) (+ factors 1)))]
      [else (loop (+ i 1) factors)])))