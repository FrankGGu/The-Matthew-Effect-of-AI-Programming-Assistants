(define (count-almost-equal-pairs nums)
  (let loop ([i 0] [j 1] [count 0])
    (cond
      [(>= i (sub1 (length nums))) count]
      [(>= j (length nums)) (loop (add1 i) (+ i 2) count)]
      [(<= (abs (- (list-ref nums i) (list-ref nums j))) 2)
       (loop i (add1 j) (add1 count))]
      [else (loop i (add1 j) count)])))