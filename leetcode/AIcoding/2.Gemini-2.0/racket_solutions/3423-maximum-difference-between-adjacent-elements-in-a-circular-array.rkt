(define (max-circular-difference nums)
  (define n (length nums))
  (if (<= n 1)
      0
      (let loop ([i 0] [max-diff 0])
        (if (= i n)
            max-diff
            (let ([diff (abs (- (list-ref nums i) (list-ref nums (modulo (+ i 1) n))))])
              (loop (+ i 1) (max max-diff diff)))))))