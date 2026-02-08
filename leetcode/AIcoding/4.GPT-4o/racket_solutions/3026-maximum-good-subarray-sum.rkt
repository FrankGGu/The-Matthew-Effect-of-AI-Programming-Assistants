(define (maximumGood nums)
  (define (good? subarray)
    (define good-count (length (filter (lambda (x) (= x 1)) subarray)))
    (define total (length subarray))
    (>= good-count (/ total 2)))

  (define max-sum -1)
  (define n (length nums))

  (for ([i (in-range n)])
    (for ([j (in-range i n)])
      (define subarray (sublist nums i (add1 j)))
      (when (good? subarray)
        (set! max-sum (max max-sum (apply + subarray))))))

  max-sum)

(maximumGood '(1 0 1 1 0 1))