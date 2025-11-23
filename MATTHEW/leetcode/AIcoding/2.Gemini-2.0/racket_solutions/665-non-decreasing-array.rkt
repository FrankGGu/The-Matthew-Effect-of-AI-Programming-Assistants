(define (check-possibility nums)
  (let loop ([i 1] [count 0])
    (cond
      [(>= i (length nums)) (<= count 1)]
      [(<= (list-ref nums (- i 1)) (list-ref nums i)) (loop (+ i 1) count)]
      [(> count 1) #f]
      [else
       (cond
         [(= i 1) (loop (+ i 1) (+ count 1))]
         [(<= (list-ref nums (- i 2)) (list-ref nums i)) (loop (+ i 1) (+ count 1))]
         [else (loop (+ i 1) (+ count 1) #:nums (list-set nums i (list-ref nums (- i 1))))])])))