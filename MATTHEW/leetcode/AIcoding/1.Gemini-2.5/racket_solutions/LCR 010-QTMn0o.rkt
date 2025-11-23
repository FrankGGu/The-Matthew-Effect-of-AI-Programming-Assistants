(define (subarray-sum nums k)
  (let loop ((nums-rest nums)
             (current-sum 0)
             (count 0)
             (prefix-sum-counts (hash 0 1)))
    (if (empty? nums-rest)
        count
        (let* ((num (first nums-rest))
               (new-current-sum (+ current-sum num))
               (target-sum (- new-current-sum k))
               (new-count (+ count (hash-ref prefix-sum-counts target-sum 0)))
               (current-sum-freq (hash-ref prefix-sum-counts new-current-sum 0))
               (new-prefix-sum-counts (hash-set prefix-sum-counts new-current-sum (+ current-sum-freq 1))))
          (loop (rest nums-rest)
                new-current-sum
                new-count
                new-prefix-sum-counts)))))