(define (smallestDivisor nums threshold)
  (define (check div)
    (foldl (lambda (x acc) (+ acc (ceiling (/ x div)))) 0 nums))

  (define (binary-search left right)
    (if (= left right)
        left
        (let* ((mid (quotient (+ left right) 2))
               (sum (check mid)))
          (if (<= sum threshold)
              (binary-search left mid)
              (binary-search (add1 mid) right)))))

  (binary-search 1 (apply max nums)))

(smallestDivisor '(1 2 5 9) 6)