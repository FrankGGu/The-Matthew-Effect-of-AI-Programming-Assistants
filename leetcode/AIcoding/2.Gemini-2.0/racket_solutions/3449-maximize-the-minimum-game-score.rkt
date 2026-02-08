(define (maximize-the-minimum-game-score nums k)
  (define (check-valid mid)
    (let loop ([i 0] [count 1] [current-sum 0])
      (cond
        [(>= i (length nums)) (>= count k)]
        [(>= (+ current-sum (list-ref nums i)) mid)
         (loop (+ i 1) (+ count 1) 0)]
        [else (loop (+ i 1) count (+ current-sum (list-ref nums i)))])))

  (define (binary-search left right)
    (cond
      [(> left right) right]
      [else
       (let ([mid (floor (+ left right) 2)])
         (if (check-valid mid)
             (binary-search (+ mid 1) right)
             (binary-search left (- mid 1))))]))

  (let ([total-sum (apply + nums)])
    (binary-search 1 (floor (/ total-sum k)))))