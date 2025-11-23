(define (minimize-maximum-pair-sum nums)
  (let* ([sorted-nums (sort nums <)]
         [n (length sorted-nums)]
         [half-n (/ n 2)]
         [first-half (take sorted-nums half-n)]
         [second-half-reversed (reverse (drop sorted-nums half-n))]
         [pair-sums (map + first-half second-half-reversed)])
    (apply max pair-sums)))