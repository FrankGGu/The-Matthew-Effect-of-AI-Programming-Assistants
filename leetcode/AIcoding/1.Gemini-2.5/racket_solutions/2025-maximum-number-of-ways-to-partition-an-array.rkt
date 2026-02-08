#lang racket

(define (maximum-ways-to-partition nums k)
  (define n (length nums))

  (if (< n 2)
      0 ; Cannot partition into two non-empty subarrays
      (begin
        (define nums-vec (list->vector nums))

        ;; Calculate prefix sums
        ;; prefix-sums[j] = sum of nums[0...j-1]
        ;; prefix-sums[0] = 0
        (define prefix-sums (make-vector (+ n 1) 0))
        (for ([i (in-range n)])
          (vector-set! prefix-sums (+ i 1) (+ (vector-ref prefix-sums i) (vector-ref nums-vec i))))

        (define total-sum (vector-ref prefix-sums n))

        ;; Case 1: No change
        (define (count-initial-partitions)
          (if (odd? total-sum)
              0
              (let ([target-half (/ total-sum 2)])
                (for/sum ([p (in-range (- n 1))]) ; p from 0 to n-2
                  (if (= (vector-ref prefix-sums (+ p 1)) target-half) 1 0)))))

        (define max-ways (count-initial-partitions))

        ;; Case 2: Change one element nums[i] to k
        (define left-freq (make-hash))  ; Stores frequencies of prefix-sums[p+1] for p < i
        (define right-freq (make-hash)) ; Stores frequencies of prefix-sums[p+1] for p >= i

        ;; Initialize right-freq with all possible prefix sums for partitions
        ;; p from 0 to n-2, so prefix-sums[p+1] from 1 to n-1
        (for ([p (in-range (- n 1))])
          (hash-update! right-freq (vector-ref prefix-sums (+ p 1)) add1 0))

        (for ([i (in-range n)]) ; i is the index of the element being changed
          (define original-val (vector-ref nums-vec i))
          (define new-total-sum (+ total-sum (- k original-val)))

          (when (even? new-total-sum)
            (define target-half-sum (/ new-total-sum 2))
            (define diff (- k original-val))
            (define current-ways 0)

            ;; Count partitions where p < i (left part does not include nums[i])
            ;; The left sum is prefix-sums[p+1].
            ;; We need prefix-sums[p+1] = target-half-sum.
            (set! current-ways (+ current-ways (hash-ref left-freq target-half-sum 0)))

            ;; Count partitions where p >= i (left part includes nums[i])
            ;; The left sum is prefix-sums[p+1] + diff.
            ;; We need prefix-sums[p+1] + diff = target-half-sum.
            ;; So, we need prefix-sums[p+1] = target-half-sum - diff.
            (set! current-ways (+ current-ways (hash-ref right-freq (- target-half-sum diff) 0)))

            (set! max-ways (max max-ways current-ways)))

          ;; Update left-freq and right-freq for the next iteration
          ;; Move prefix-sums[i+1] from right-freq to left-freq
          ;; This prefix-sums[i+1] corresponds to the sum of nums[0...i].
          ;; It becomes a "left" sum for partitions where the change is at index i+1 or later.
          (when (< i (- n 1)) ; Only move if prefix-sums[i+1] is a valid partition point
            (define val-to-move (vector-ref prefix-sums (+ i 1)))
            (hash-update! right-freq val-to-move sub1 0)
            (hash-update! left-freq val-to-move add1 0)))

        max-ways)))