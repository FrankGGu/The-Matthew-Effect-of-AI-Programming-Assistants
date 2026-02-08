#lang racket

(define (min-operations-to-reduce-x-to-zero nums x)
  (define n (length nums))
  (define prefix-sum-map (make-hash))

  ;; Populate prefix-sum-map
  ;; Key: prefix sum, Value: number of elements from the left to achieve that sum
  ;; A sum of 0 is achieved by taking 0 elements from the left.
  (hash-set! prefix-sum-map 0 0) 
  (define current-prefix-sum 0)
  (for ([i (in-range n)])
    (set! current-prefix-sum (+ current-prefix-sum (list-ref nums i)))
    ;; Since nums[i] >= 1, current-prefix-sum is strictly increasing.
    ;; Thus, each sum will be unique and encountered only once.
    (hash-set! prefix-sum-map current-prefix-sum (+ i 1)))

  ;; Initialize min-ops with a value larger than any possible result (n is the maximum operations).
  (define min-ops (+ n 1)) 

  (define current-suffix-sum 0)
  ;; Iterate through all possible number of elements (j) to remove from the right.
  ;; j goes from 0 to n.
  (for ([j (in-range (+ n 1))])
    ;; If j > 0, add the j-th element from the right to current-suffix-sum.
    ;; The j-th element from the right is at index (n - j).
    (when (> j 0)
      (set! current-suffix-sum (+ current-suffix-sum (list-ref nums (- n j)))))

    ;; Optimization: If current-suffix-sum already exceeds x,
    ;; any further suffix sums (by adding more positive elements) will also exceed x.
    (when (> current-suffix-sum x)
      (break))

    ;; Calculate the target sum needed from the prefix to reach x.
    (define target-prefix-sum (- x current-suffix-sum))

    ;; Check if this target-prefix-sum can be achieved from the left.
    (when (hash-has-key? prefix-sum-map target-prefix-sum)
      (define prefix-len (hash-ref prefix-sum-map target-prefix-sum))
      ;; Ensure that the combined number of elements from prefix and suffix
      ;; does not exceed the total number of elements in the array.
      ;; This means prefix and suffix elements must not overlap.
      (when (<= (+ prefix-len j) n)
        (set! min-ops (min min-ops (+ prefix-len j))))))

  ;; If min-ops is still its initial large value, it means no valid combination was found.
  (if (= min-ops (+ n 1))
      -1
      min-ops))