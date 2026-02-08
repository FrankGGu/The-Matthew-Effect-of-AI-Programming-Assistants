(define (minimum-sum-of-mountain-triplets-i nums)
  (let* ((n (length nums))
         (min-sum (add1 (expt 10 9)))) ; Initialize min-sum to a value larger than any possible sum (max sum is 3 * 10^8)

    (for* ([j (in-range 1 (- n 1))]
           [i (in-range 0 j)]
           [k (in-range (+ j 1) n)])
      (let ((num-i (list-ref nums i))
            (num-j (list-ref nums j))
            (num-k (list-ref nums k)))
        (when (and (< num-i num-j)
                   (< num-k num-j))
          (set! min-sum (min min-sum (+ num-i num-j num-k))))))

    (if (= min-sum (add1 (expt 10 9)))
        -1
        min-sum)))