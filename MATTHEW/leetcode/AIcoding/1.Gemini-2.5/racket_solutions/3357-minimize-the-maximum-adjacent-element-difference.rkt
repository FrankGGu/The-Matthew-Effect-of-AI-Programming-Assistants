(define (minimize-the-maximum-adjacent-element-difference nums p)
  (define n (length nums))

  ;; Handle edge cases for n
  ;; If n is 0 or 1, there are no adjacent elements, so the maximum difference is 0.
  ;; This also covers cases where p is large enough to remove all but one element.
  (cond
    ((< n 2)
     0)
    (else
     ;; Sort nums and convert to a vector for O(1) element access
     (define sorted-vec (list->vector (sort nums <)))

     ;; `check` function for binary search.
     ;; Returns true if it's possible to form a subsequence by removing at most `p` elements
     ;; such that all adjacent differences in the subsequence are at most `max-diff`.
     ;; This is equivalent to checking if we can find a subsequence of length at least `n - p`
     ;; where all adjacent differences are at most `max-diff`.
     ;; The greedy strategy is to always keep an element if it maintains the `max-diff` constraint
     ;; with the previously kept element, to maximize the length of the subsequence.
     (define (check max-diff)
       (let loop ((i 1) ; Start from the second element
                  (kept-elements 1) ; The first element is always kept
                  (last-kept-val (vector-ref sorted-vec 0))) ; Value of the last element kept
         (if (>= i n)
             ;; If we've iterated through all elements, check if the number of removed elements
             ;; (n - kept-elements) is less than or equal to p.
             (<= (- n kept-elements) p)
             (if (<= (- (vector-ref sorted-vec i) last-kept-val) max-diff)
                 ;; If current element can be kept, keep it and update last-kept-val
                 (loop (+ i 1) (+ kept-elements 1) (vector-ref sorted-vec i))
                 ;; If current element cannot be kept, remove it (skip it)
                 (loop (+ i 1) kept-elements last-kept-val)))))

     ;; Binary search for the minimum possible maximum adjacent difference.
     ;; The smallest possible difference is 0.
     ;; The largest possible difference is the difference between the largest and smallest elements.
     (let loop-bs ((low 0)
                   (high (- (vector-ref sorted-vec (- n 1)) (vector-ref sorted-vec 0)))
                   (ans high)) ; `ans` stores the smallest `max-diff` for which `check` returns true
       (if (> low high)
           ans
           (let ((mid (+ low (quotient (- high low) 2))))
             (if (check mid)
                 ;; If `mid` is a possible maximum difference, try for an even smaller one
                 (loop-bs low (- mid 1) mid)
                 ;; If `mid` is not possible, we need a larger maximum difference
                 (loop-bs (+ mid 1) high ans))))))))