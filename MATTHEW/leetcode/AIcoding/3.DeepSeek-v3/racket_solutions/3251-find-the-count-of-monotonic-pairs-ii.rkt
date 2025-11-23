(define (count-monotonic-pairs nums)
  (let loop ([i 0] [j 1] [count 0])
    (cond
      [(>= j (length nums)) count]
      [(<= (list-ref nums i) (list-ref nums j))
       (loop i (+ j 1) (+ count (- j i)))]
      [else (loop (+ i 1) (max (+ i 1) j) count)])))