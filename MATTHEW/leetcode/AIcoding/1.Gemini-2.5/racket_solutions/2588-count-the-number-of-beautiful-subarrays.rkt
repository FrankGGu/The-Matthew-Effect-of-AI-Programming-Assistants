(define (number-of-beautiful-subarrays nums k)
  (let ([count 0]
        [current-odd-count 0]
        [prefix-sum-counts (make-hash)])

    (hash-set! prefix-sum-counts 0 1)

    (for ([num (in-list nums)])
      (when (odd? num)
        (set! current-odd-count (+ current-odd-count 1)))

      (let ([target-prefix-sum (- current-odd-count k)])
        (when (hash-has-key? prefix-sum-counts target-prefix-sum)
          (set! count (+ count (hash-ref prefix-sum-counts target-prefix-sum)))))

      (hash-update! prefix-sum-counts
                    current-odd-count
                    (lambda (val) (+ val 1))
                    0))
    count))