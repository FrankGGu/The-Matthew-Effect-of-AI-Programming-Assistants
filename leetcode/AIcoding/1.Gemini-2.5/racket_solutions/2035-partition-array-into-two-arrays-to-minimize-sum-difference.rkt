#lang racket

(define (min-sum-diff nums)
  (define len (vector-length nums))
  (define n (/ len 2))
  (define total-sum (vector-foldl + 0 nums))

  (define left-half (vector-copy nums 0 n))
  (define right-half (vector-copy nums n len))

  ; Function to generate all possible subset sums of a given size
  ; Returns a list of sums
  (define (generate-sums arr target-k)
    (define sums '()) ; Use a mutable list for simplicity

    (define (backtrack idx current-sum current-k)
      (cond
        [(= current-k target-k)
         (set! sums (cons current-sum sums))]
        [(= idx (vector-length arr))
         ; Reached end of array, but not target-k elements
         ]
        [else
         ; Option 1: Include current element
         (backtrack (+ idx 1) (+ current-sum (vector-ref arr idx)) (+ current-k 1))
         ; Option 2: Exclude current element
         (backtrack (+ idx 1) current-sum current-k)]))

    (backtrack 0 0 0)
    sums)

  ; Store sums for different k values in a vector of lists
  ; left-sums[k] will be a list of sums of k elements from left-half
  (define left-sums (make-vector (+ n 1) '()))
  (for ([k (in-range (+ n 1))])
    (vector-set! left-sums k (generate-sums left-half k)))

  (define right-sums (make-vector (+ n 1) '()))
  (for ([k (in-range (+ n 1))])
    (vector-set! right-sums k (generate-sums right-half k)))

  ; Sort all lists in right-sums for efficient lookup
  (for ([k (in-range (+ n 1))])
    (vector-set! right-sums k (sort (vector-ref right-sums k) <)))

  ; Initialize with total-sum (e.g., if one partition is empty, other is total-sum)
  ; This is the max possible difference, abs(total-sum - 0)
  (define min-diff (abs total-sum))

  ; Helper for binary search to find index of first element >= target
  ; Returns an index from 0 to (length sorted-list) inclusive.
  ; If target is greater than all elements, returns (length sorted-list).
  (define (lower-bound sorted-list target)
    (define list-len (length sorted-list))
    (define (bs low high) ; low is inclusive, high is exclusive
      (cond
        [(= low high) low]
        [else
         (define mid (+ low (quotient (- high low) 2)))
         (if (>= (list-ref sorted-list mid) target)
             (bs low mid)
             (bs (+ mid 1) high))]))
    (if (empty? sorted-list)
        0
        (bs 0 list-len)))

  (for ([k (in-range (+ n 1))]) ; k elements from left-half
    (define current-left-sums (vector-ref left-sums k))
    (define current-right-sums (vector-ref right-sums (- n k))) ; n-k elements from right-half

    (for ([s1 current-left-sums])
      ; We want s1 + s2 to be close to total-sum / 2
      ; So s2 should be close to (total-sum / 2) - s1
      (define target-s2 (- (/ total-sum 2) s1))

      (define idx (lower-bound current-right-sums target-s2))
      (define len-right (length current-right-sums))

      ; Check element at idx
      (when (< idx len-right)
        (define s2 (list-ref current-right-sums idx))
        (set! min-diff (min min-diff (abs (- (* 2 (+ s1 s2)) total-sum)))))

      ; Check element at idx - 1
      (when (> idx 0)
        (define s2 (list-ref current-right-sums (- idx 1)))
        (set! min-diff (min min-diff (abs (- (* 2 (+ s1 s2)) total-sum)))))))

  min-diff)