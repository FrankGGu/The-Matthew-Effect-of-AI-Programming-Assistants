(define (count-subarrays nums k)
  (let loop ([left 0] [right 0] [sum 0] [count 0])
    (cond
      [(>= right (length nums)) count]
      [else
       (let* ([new-sum (+ sum (list-ref nums right))]
              [new-count (+ count (- right left -1))]
              [valid (<= (* new-sum (- right left -1)) k)])
         (if valid
             (loop left (+ right 1) new-sum new-count)
             (loop (+ left 1) right (- sum (list-ref nums left)) count)))])))