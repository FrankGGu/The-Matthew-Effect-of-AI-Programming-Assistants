(define (count-matching-subarrays pattern nums)
  (define n (length nums))
  (define m (length pattern))
  (define (compare i j)
    (cond
      [(< (list-ref nums i) (list-ref nums j)) -1]
      [(= (list-ref nums i) (list-ref nums j)) 0]
      [else 1]))

  (define (check-match start)
    (let loop ([i 0])
      (cond
        [(= i m) #t]
        [else
         (let ([expected-relation (list-ref pattern i)])
           (let ([actual-relation (compare (+ start i) (+ start i 1))])
             (cond
               [(= expected-relation actual-relation) (loop (+ i 1))]
               [else #f])))])))

  (let loop ([start 0] [count 0])
    (cond
      [(> start (- n 1)) count]
      [else
       (if (check-match start)
           (loop (+ start 1) (+ count 1))
           (loop (+ start 1) count))]))
  )