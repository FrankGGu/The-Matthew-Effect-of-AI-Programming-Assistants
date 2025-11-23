(define (number-of-beautiful-partitions nums k minLength)
  (define n (length nums))
  (define mod 1000000007)

  (define (is-prime? num)
    (cond
      [(<= num 1) #f]
      [(= num 2) #t]
      [(even? num) #f]
      [else
       (let loop ([i 3])
         (cond
           [(> (* i i) num) #t]
           [(= (remainder num i) 0) #f]
           [else (loop (+ i 2))]))]))

  (define (is-beautiful? i)
    (and (>= i 0) (< i n) (is-prime? (list-ref nums i))))

  (define (solve idx partitions)
    (cond
      [(= idx n) (if (= partitions k) 1 0)]
      [(> partitions k) 0]
      [else
       (let loop ([j (+ idx minLength)])
         (cond
           [(> j n) 0]
           [(and (is-beautiful? idx) (is-beautiful? (- j 1)))
            (let ([res1 (solve j (+ partitions 1))])
              (if (> j (+ idx minLength))
                  (let ([res2 (loop (+ j 1))])
                    (remainder (+ res1 res2) mod))
                  res1))]
           [else (if (> j (+ idx minLength))
                     (loop (+ j 1))
                     0)]))]))

  (solve 0 0))