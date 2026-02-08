(define/contract (delete-greatest-value grid)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (define (delete-row row)
    (if (null? row)
        row
        (let ([max-val (apply max row)])
          (remove max-val row))))
  (let loop ([grid grid] [sum 0])
    (if (ormap null? grid)
        sum
        (let ([max-in-rows (map (lambda (row) (apply max row)) grid)])
          (loop (map delete-row grid) (+ sum (apply max max-in-rows)))))))