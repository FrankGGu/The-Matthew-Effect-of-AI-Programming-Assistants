(define (numOfWays nums)
  (define (count-pairs x)
    (let loop ((i 0) (count 0))
      (if (= i (length nums))
          count
          (let ((y (* x x)))
            (if (and (not (= (list-ref nums i) 0))
                     (= (quotient y (list-ref nums i)) (list-ref nums i)))
                (loop (+ i 1) (+ count 1))
                (loop (+ i 1) count))))))
  (define result (for/fold ([acc 0]) ([x nums]) (+ acc (count-pairs x))))
  (/ result 2))

(numOfWays '(1 2 3 4 5 6 7 8 9 10))