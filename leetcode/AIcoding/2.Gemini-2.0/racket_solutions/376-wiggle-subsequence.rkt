(define (wiggle-max-length nums)
  (let ([n (length nums)])
    (if (<= n 1)
        n
        (let loop ([i 1]
                   [up 1]
                   [down 1])
          (if (= i n)
              (max up down)
              (let ([diff (- (list-ref nums i) (list-ref nums (- i 1)))])
                (cond
                  [(> diff 0) (loop (+ i 1) (+ down 1) down)]
                  [(< diff 0) (loop (+ i 1) up (+ up 1))]
                  [else (loop (+ i 1) up down)])))))))