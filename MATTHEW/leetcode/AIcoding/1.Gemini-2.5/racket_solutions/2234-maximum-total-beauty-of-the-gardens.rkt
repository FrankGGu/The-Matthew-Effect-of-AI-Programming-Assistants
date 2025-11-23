#lang racket

(define (maximum-total-beauty flowers newFlowers target full partial)
  (define n (length flowers))

  ;; Sort flowers in ascending order and convert to a vector for O(1) access
  (define F (vector-sort < (list->vector flowers)))

  ;; Calculate prefix sums for efficient range sum queries
  ;; P[k] stores the sum of F[0]...F[k-1]
  (define P (make-vector (+ n 1) 0))
  (let loop ((k 0) (current-sum 0))
    (when (< k n)
      (let ((next-sum (+ current-sum (vector-ref F k))))
        (vector-set! P (+ k 1) next-sum)
        (loop (+ k 1) next-sum))))

  ;; Helper function for binary search (upper_bound equivalent)
  ;; Returns the index of the first element in vec[start...end-1] that is not less than val.
  ;; If all elements are less than val, returns end.
  (define (binary-search-upper-bound vec start end val)
    (let loop ((low start) (high end))
      (if (< low high)
          (let ((mid (+ low (quotient (- high low) 2))))
            (if (< (vector-ref vec mid) val)
                (loop (+ mid 1) high)
                (loop low mid)))
          low)))

  (let loop-i ((i n) (max-beauty 0)) ; i is the number of gardens we try to make complete
    (if (< i 0)
        max-beauty
        (let* ((cost-for-complete 0)
               (j-start (- n i))) ; Index of the first garden in the "complete" set (F[n-i]...F[n-1])

          ;; Calculate cost to make the 'i' rightmost gardens complete
          (when (> i 0)
            (if (< (vector-ref F j-start) target)
                ;; If the smallest of the 'i' complete gardens is less than target,
                ;; we need to add flowers to some of them.
                ;; Find how many of these 'i' gardens are less than target.
                (let* ((k-idx (binary-search-upper-bound F j-start n target))
                       (num-gardens-to-fill (- k-idx j-start))
                       (sum-flowers-to-fill (- (vector-ref P k-idx) (vector-ref P j-start))))
                  (set! cost-for-complete (- (* num-gardens-to-fill target) sum-flowers-to-fill)))
                ;; Else, all 'i' gardens are already >= target, so cost-for-complete remains 0
                ))

          (if (> cost-for-complete newFlowers)
              ;; If we cannot afford to make these 'i' gardens complete, try fewer complete gardens
              (loop-i (- i 1) max-beauty)
              (let* ((new-flowers-remaining (- newFlowers cost-for-complete))
                     (current-beauty (* i full))
                     (m (- n i)) ; Number of partial gardens (F[0]...F[m-1])
                     (min-partial-flowers 0))

                (when (> m 0)
                  ;; Binary search for the maximum possible minimum flower count (ans-X)
                  ;; for the 'm' partial gardens, using new-flowers-remaining.
                  ;; ans-X must be < target.
                  (let loop-bs ((low 0) (high (- target 1)) (ans-X 0))
                    (if (<= low high)
                        (let ((mid (+ low (quotient (- high low) 2))))
                          (let* ((k-idx (binary-search-upper-bound F 0 m mid)) ; Count elements in F[0...m-1] less than mid
                                 (cost-to-raise (- (* k-idx mid) (vector-ref P k-idx))))
                            (if (<= cost-to-raise new-flowers-remaining)
                                (loop-bs (+ mid 1) high mid) ; mid is achievable, try a higher minimum
                                (loop-bs low (- mid 1) ans-X)))) ; mid is too high, try a lower minimum
                        (set! min-partial-flowers ans-X))))

                (set! current-beauty (+ current-beauty (* min-partial-flowers partial)))
                (loop-i (- i 1) (max max-beauty current-beauty))))))))