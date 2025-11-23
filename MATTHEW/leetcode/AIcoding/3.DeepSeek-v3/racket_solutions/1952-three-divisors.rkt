(define/contract (is-three n)
  (-> exact-integer? boolean?)
  (let loop ([i 2] [count 0])
    (cond
      [(> (* i i) n) (= count 1)]
      [(= (modulo n i) 0)
       (if (= i (/ n i))
           (loop (+ i 1) (+ count 1))
           (loop (+ i 1) (+ count 2)))]
      [else (loop (+ i 1) count)])))