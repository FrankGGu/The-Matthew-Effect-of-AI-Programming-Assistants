(define (maxSumAfterRemoval nums val)
  (define (calculate max-sum nums)
    (foldl (lambda (x acc)
              (if (= x val)
                  (max acc 0)
                  (max (+ acc x) x)))
            0
            nums))
  (define (max-sum nums)
    (foldl (lambda (x acc)
              (max acc x))
            0
            nums))
  (define nums-without-val (filter (lambda (x) (not (= x val))) nums))
  (max (max-sum nums-without-val) (calculate (max-sum nums-without-val) nums)))

(define (maxSumAfterRemovalWrapper nums val)
  (maxSumAfterRemoval nums val))