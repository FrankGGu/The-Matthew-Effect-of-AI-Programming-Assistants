(define (moves-to-make-zigzag nums)
  (define n (length nums))
  (define (calculate-moves start)
    (let loop ([i start] [moves 0])
      (cond
        [(>= i n) moves]
        [else
         (let ([left (if (= i 0) +inf.0 (list-ref nums (- i 1)))]
               [right (if (= i (- n 1)) +inf.0 (list-ref nums (+ i 1)))])
           (let ([target (min left right)])
             (if (< (list-ref nums i) target)
                 (loop (+ i 2) moves)
                 (loop (+ i 2) (+ moves (- (list-ref nums i) target -1))))))]))))
  (min (calculate-moves 0) (calculate-moves 1)))