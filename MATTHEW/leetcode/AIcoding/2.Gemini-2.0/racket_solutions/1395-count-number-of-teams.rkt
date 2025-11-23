(define (numTeams rating)
  (let ([n (length rating)])
    (let loop ([i 0] [count 0])
      (if (= i n)
          count
          (let ([less-left (count (lambda (x) (< x (list-ref rating i))) (take rating i))]
                [greater-left (count (lambda (x) (> x (list-ref rating i))) (take rating i))]
                [less-right (count (lambda (x) (< x (list-ref rating i))) (drop rating (+ i 1)))]
                [greater-right (count (lambda (x) (> x (list-ref rating i))) (drop rating (+ i 1)))])
            (loop (+ i 1) (+ count (+ (* less-left greater-right) (* greater-left less-right)))))))))