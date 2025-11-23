(define/contract (kth-factor n k)
  (-> exact-integer? exact-integer? exact-integer?)
  (let loop ([i 1] [count 0])
    (cond
      [(> i n) -1]
      [(= (modulo n i) 0)
       (if (= (+ count 1) k)
           i
           (loop (+ i 1) (+ count 1)))]
      [else (loop (+ i 1) count)])))