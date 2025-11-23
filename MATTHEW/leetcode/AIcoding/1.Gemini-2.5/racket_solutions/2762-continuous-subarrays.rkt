#lang racket

(define (subarray-sum-equals-k nums k)
  (let ([count 0]
        [current-sum 0]
        [prefix-sums (make-hash)])

    (hash-set! prefix-sums 0 1)

    (for-each
     (lambda (num)
       (set! current-sum (+ current-sum num))

       (let ([target-sum (- current-sum k)])
         (when (hash-has-key? prefix-sums target-sum)
           (set! count (+ count (hash-ref prefix-sums target-sum)))))

       (hash-set! prefix-sums
                  current-sum
                  (+ (hash-ref prefix-sums current-sum 0) 1)))
     nums)

    count))