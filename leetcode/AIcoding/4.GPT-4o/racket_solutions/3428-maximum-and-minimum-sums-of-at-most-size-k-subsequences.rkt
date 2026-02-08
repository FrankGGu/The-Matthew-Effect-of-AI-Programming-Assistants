(define (maxMinSums nums k)
  (define (sum lst) (foldl + 0 lst))
  (define max-sum (sum (take (sort nums >) k)))
  (define min-sum (sum (take (sort nums <) k)))
  (list max-sum min-sum))

(maxMinSums '(1 2 3 4 5) 3)