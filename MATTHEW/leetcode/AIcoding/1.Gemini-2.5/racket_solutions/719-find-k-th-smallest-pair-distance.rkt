#lang racket

(define (smallest-pair-distance nums k)
  (let* ([num-vec (list->vector nums)] ; Convert list to vector for efficient indexing
         [n (vector-length num-vec)]
         ; Sort the array in ascending order
         [sorted-nums (vector-sort < num-vec)]
         ; Binary search range for the distance
         [low 0]
         ; The maximum possible distance is the difference between the largest and smallest elements
         [high (- (vector-ref sorted-nums (sub1 n)) (vector-ref sorted-nums 0))])

    ;; Helper function to count the number of pairs with a distance less than or equal to `target-dist`.
    ;; Uses a two-pointer approach (sliding window) on the sorted array.
    (define (count-pairs target-dist)
      (let loop-right ([right 0] [left 0] [current-count 0])
        (if (= right n)
            current-count
            (let loop-left ([current-left left])
              ;; Move 'left' pointer forward as long as the distance between nums[right] and nums[current-left]
              ;; exceeds the target-dist.
              (if (and (< current-left right)
                       (> (- (vector-ref sorted-nums right) (vector-ref sorted-nums current-left)) target-dist))
                  (loop-left (+ current-left 1))
                  ;; All elements from current-left to right-1 form a valid pair with nums[right]
                  ;; (i.e., their distance is <= target-dist).
                  ;; Add the number of such valid 'left' indices (right - current-left) to the total count.
                  (loop-right (+ right 1) current-left (+ current-count (- right current-left))))))))

    ;; Binary search for the k-th smallest distance.
    ;; The search space is the range of possible distances [low, high].
    (let binary-search-loop ([low low] [high high])
      (if (= low high)
          ;; When low and high converge, we found the smallest distance 'd' such that
          ;; there are at least 'k' pairs with distance <= 'd'.
          low
          (let ([mid (+ low (quotient (- high low) 2))]) ; Calculate mid-point (floor division)
            (if (< (count-pairs mid) k)
                ;; If the number of pairs with distance <= mid is less than k,
                ;; it means the k-th smallest distance must be greater than mid.
                (binary-search-loop (+ mid 1) high)
                ;; Otherwise, if count >= k, mid could be the answer, or the answer is smaller.
                ;; So, we try to find a smaller distance in the range [low, mid].
                (binary-search-loop low mid)))))))