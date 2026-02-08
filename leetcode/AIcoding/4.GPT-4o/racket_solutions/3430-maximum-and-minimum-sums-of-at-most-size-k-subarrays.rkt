(define (maximum-and-minimum-sums nums k)
  (define (max-subarray-sum subarray)
    (foldl max 0 subarray))

  (define (min-subarray-sum subarray)
    (foldl min 0 subarray))

  (define max-sum (apply max (map (lambda (i) (max-subarray-sum (sublist nums i (+ i k)))) (range (- (length nums) k 1)))))
  (define min-sum (apply min (map (lambda (i) (min-subarray-sum (sublist nums i (+ i k)))) (range (- (length nums) k 1)))))

  (list max-sum min-sum))

(maximum-and-minimum-sums '(1 2 3 4 5) 2)