(define (count-range-sum nums lower upper)
  (define n (length nums))
  (define prefix-sums (make-vector (+ n 1) 0))

  ;; Calculate prefix sums
  (for ([i (in-range n)])
    (vector-set! prefix-sums (+ i 1) (+ (vector-ref prefix-sums i) (list-ref nums i))))

  ;; Recursive merge-sort-like function
  ;; arr: the prefix_sums vector
  ;; start: inclusive start index of the current sub-array
  ;; end: exclusive end index of the current sub-array
  (define (merge-sort-and-count arr start end)
    (if (<= (- end start) 1) ; Base case: 0 or 1 element, no range sums possible
        0
        (let* ([mid (+ start (quotient (- end start) 2))]
               [count ( + (merge-sort-and-count arr start mid) ; Count in left half
                           (merge-sort-and-count arr mid end))] ; Count in right half
               [j mid]   ; Pointer for the lower bound in the right half
               [k mid]   ; Pointer for the upper bound in the right half
               [temp (make-vector (- end start))]) ; Temporary array for merging

          ;; Count cross-boundary sums
          ;; For each element arr[p] in the left half,
          ;; find elements arr[j_idx] in the right half such that
          ;; lower <= arr[j_idx] - arr[p] <= upper
          ;; which is equivalent to arr[p] + lower <= arr[j_idx] <= arr[p] + upper
          (for ([p (in-range start mid)])
            ;; Find the first j_idx such that arr[j_idx] >= arr[p] + lower
            (while (and (< j end) (< (vector-ref arr j) (+ (vector-ref arr p) lower)))
              (set! j (+ j 1)))
            ;; Find the first k_idx such that arr[k_idx] > arr[p] + upper
            (while (and (< k end) (<= (vector-ref arr k) (+ (vector-ref arr p) upper)))
              (set! k (+ k 1)))
            ;; The number of elements in [j, k) is k - j
            (set! count (+ count (- k j))))

          ;; Merge the two sorted halves (arr[start...mid-1] and arr[mid...end-1])
          (let ([p1 start] [p2 mid] [idx 0])
            (while (and (< p1 mid) (< p2 end))
              (if (<= (vector-ref arr p1) (vector-ref arr p2))
                  (begin (vector-set! temp idx (vector-ref arr p1)) (set! p1 (+ p1 1)))
                  (begin (vector-set! temp idx (vector-ref arr p2)) (set! p2 (+ p2 1))))
              (set! idx (+ idx 1)))
            ;; Copy remaining elements from left half, if any
            (while (< p1 mid)
              (vector-set! temp idx (vector-ref arr p1))
              (set! p1 (+ p1 1))
              (set! idx (+ idx 1)))
            ;; Copy remaining elements from right half, if any
            (while (< p2 end)
              (vector-set! temp idx (vector-ref arr p2))
              (set! p2 (+ p2 1))
              (set! idx (+ idx 1)))

            ;; Copy merged elements back to the original array
            (for ([l (in-range (- end start))])
              (vector-set! arr (+ start l) (vector-ref temp l))))

          count)))

  ;; Call the recursive function on the entire prefix_sums array
  (merge-sort-and-count prefix-sums 0 (+ n 1)))