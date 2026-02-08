(define (min-potion-time potions)
  (define (solve potions k)
    (cond
      [(empty? potions) 0]
      [else
       (define (cost p)
         (max 0 (- p k)))
       (define (total-cost ps)
         (foldl + 0 (map cost ps)))
       (let loop ([left (rest potions)]
                  [curr-cost (cost (first potions))])
         (if (empty? left)
             (+ curr-cost (total-cost (rest potions)))
             (let ([next-cost (cost (first left))])
               (loop (rest left)
                     (max curr-cost next-cost)))))]))

  (define (binary-search potions)
    (define (check k)
      (let ([times (map (lambda (p) (ceiling (/ (max 0 (- p k)) 1.0))) potions)])
        (<= (apply + times) (length potions))))

    (let loop ([low 0] [high (apply max potions)])
      (cond
        [(>= low high) low]
        [else
         (let ([mid (floor (/ (+ low high) 2))])
           (if (check mid)
               (loop low mid)
               (loop (+ mid 1) high)))])))

  (solve potions (binary-search potions)))