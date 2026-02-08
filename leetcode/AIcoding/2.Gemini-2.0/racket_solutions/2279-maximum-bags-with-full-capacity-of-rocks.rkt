(define (maximum-bags rocks capacity)
  (let* ([n (length rocks)]
         [diffs (sort (map - capacity rocks) <)])
    (let loop ([i 0] [current-capacity 0])
      (cond
        [(>= i n) i]
        [(>= (+ current-capacity (list-ref diffs i)) 0)
         (loop (+ i 1) (+ current-capacity (list-ref diffs i)))]
        [else i]))))