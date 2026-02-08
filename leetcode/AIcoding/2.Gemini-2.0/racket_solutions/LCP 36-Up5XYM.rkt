(define (max-number-of-groups nums)
  (define n (length nums))
  (define sorted-nums (sort nums <))
  (define (helper current-sum count remaining)
    (cond
      [(empty? remaining) count]
      [else
       (let loop ([i 0])
         (cond
           [(>= i (length remaining)) count]
           [(>= (+ current-sum (list-ref remaining i)) (list-ref remaining i))
            (helper (+ current-sum (list-ref remaining i)) (+ count 1) (append (take remaining i) (drop remaining (+ i 1))))]
           [else (loop (+ i 1))]))]))
  (helper 0 0 sorted-nums))