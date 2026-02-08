(define (max-candies candies k)
  (define (can-distribute x)
    (apply + (map (lambda (c) (quotient c x)) candies)) >= k)

  (define (binary-search low high)
    (if (>= low high)
        low
        (let ((mid (quotient (+ low high) 2)))
          (if (can-distribute mid)
              (binary-search mid high)
              (binary-search low mid)))))

  (binary-search 1 (apply max candies)))