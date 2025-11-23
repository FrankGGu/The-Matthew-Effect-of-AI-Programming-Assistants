(define (sum-digit-differences nums)
  (define (digit-difference x y)
    (let loop ([x x] [y y] [diff 0])
      (if (and (zero? x) (zero? y))
          diff
          (loop (quotient x 10) (quotient y 10) 
                (+ diff (if (= (remainder x 10) (remainder y 10)) 0 1)))))
  (let loop ([nums nums] [total 0])
    (if (null? nums)
        total
        (loop (cdr nums) 
              (+ total (apply + (map (lambda (y) (digit-difference (car nums) y)) (cdr nums)))))))