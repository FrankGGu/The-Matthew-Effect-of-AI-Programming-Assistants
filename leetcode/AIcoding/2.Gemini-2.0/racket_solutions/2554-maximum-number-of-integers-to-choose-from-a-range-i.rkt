(define (max-count banned n max-sum)
  (define (solve banned n max-sum seen)
    (cond
      [(> max-sum 0)
       (let loop ([i 1] [count 0] [current-sum 0] [current-seen seen])
         (cond
           [(> i n) count]
           [(or (hash-has-key? current-seen i) (> (+ current-sum i) max-sum)) (loop (+ i 1) count current-sum current-seen)]
           [else (loop (+ i 1) (+ count 1) (+ current-sum i) (hash-set current-seen i #t))]))]
      [else 0]))
  (solve banned n max-sum (list->hash (map (lambda (x) (cons x #t)) banned))))