(define (min-array-sum nums k)
  (define (check mid)
    (let loop ([i 0] [count 1] [current-sum 0])
      (cond
        [(>= i (length nums)) count]
        [(> (+ current-sum (list-ref nums i)) mid)
         (loop i (+ count 1) (list-ref nums i))]
        [else (loop (+ i 1) count (+ current-sum (list-ref nums i)))])))

  (define (binary-search left right)
    (cond
      [(<= left right)
       (let ([mid (floor (/ (+ left right) 2))])
         (if (<= (check mid) k)
             (binary-search left (- mid 1))
             (binary-search (+ mid 1) right)))
      [else left]))

  (let ([total-sum (apply + nums)]
        [max-num (apply max nums)])
    (binary-search max-num total-sum)))