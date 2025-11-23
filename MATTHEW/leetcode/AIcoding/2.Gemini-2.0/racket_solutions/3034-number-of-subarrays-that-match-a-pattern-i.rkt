(define (count-matching-subarrays nums pattern)
  (let* ((n (length nums))
         (m (length pattern))
         (count 0))
    (for ([i (in-range (- n m))])
      (let loop ([j 0])
        (cond
          [(>= j m) (set! count (+ count 1))]
          [(and (< j m)
                (cond
                  [(= (list-ref pattern j) 1) (> (list-ref nums (+ i j 1)) (list-ref nums (+ i j)))]
                  [(eq? (list-ref pattern j) 0) (= (list-ref nums (+ i j 1)) (list-ref nums (+ i j)))]
                  [else (< (list-ref nums (+ i j 1)) (list-ref nums (+ i j)))]))
           (loop (+ j 1))]
          [else #f]))
      )
    count))