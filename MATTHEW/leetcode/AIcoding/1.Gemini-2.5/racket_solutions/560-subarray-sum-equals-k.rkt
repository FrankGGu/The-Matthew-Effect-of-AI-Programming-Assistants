(define (subarray-sum-equals-k nums k)
  (let ([count 0]
        [current-sum 0]
        [sum-counts (make-hash)])
    (hash-set! sum-counts 0 1)

    (for-each
     (lambda (num)
       (set! current-sum (+ current-sum num))
       (let ([target-sum (- current-sum k)])
         (when (hash-has-key? sum-counts target-sum)
           (set! count (+ count (hash-ref sum-counts target-sum)))))
       (hash-update! sum-counts current-sum (lambda (v) (+ v 1)) 0))
     nums)
    count))