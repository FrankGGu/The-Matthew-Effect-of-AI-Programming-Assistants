(define (find-the-ball n k)
  (let loop ([pos 0] [dir 1] [time 0])
    (cond
      [(= time k) pos]
      [(and (= pos 0) (= dir -1)) (loop pos (- dir) (add1 time))]
      [(and (= pos (sub1 n)) (= dir 1)) (loop pos (- dir) (add1 time))]
      [else (loop (+ pos dir) dir (add1 time))])))