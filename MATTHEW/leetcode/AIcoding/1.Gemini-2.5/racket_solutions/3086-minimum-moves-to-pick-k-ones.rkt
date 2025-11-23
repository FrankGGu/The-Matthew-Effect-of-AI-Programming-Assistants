(define (min-moves-to-pick-k-ones nums k)
  (define ones-indices
    (for/list ([num (in-indexed nums)]
               #:when (= num 1))
      (car num)))

  (define m (length ones-indices))

  (cond
    [(= k 0) 0]
    [(< m k) -1] ; Return -1 if it's impossible to pick k ones
    [(= k m) 0]  ; If k equals the total number of ones, no moves are needed
    [else
     ;; Step 1: Create q_values where q_j = p_j - j
     ;; p_j are the original indices of ones, j is the relative index within the sequence of ones
     (define q-values
       (for/list ([p (in-list ones-indices)]
                  [idx (in-range m)])
         (- p idx)))

     ;; Step 2: Calculate prefix sums for q_values
     ;; This allows O(1) sum queries for any subsegment of q_values
     (define prefix-q
       (let loop ([lst q-values] [current-sum 0] [acc '()])
         (if (empty? lst)
             (reverse acc)
             (let ([new-sum (+ current-sum (car lst))])
               (loop (cdr lst) new-sum (cons new-sum acc))))))

     (define min-cost +inf.0)

     ;; Step 3: Iterate through all possible windows of k ones
     ;; The window starts at index i in the `ones-indices` list.
     ;; The corresponding q_values window is from index i to i + k - 1.
     (for ([i (in-range (- m k) (+ 1 (- m k)))])
       (let* ([mid-idx-in-window (floor (/ k 2))] ; 0-based index of the median in the current window of k elements
              [median-q (list-ref q-values (+ i mid-idx-in-window))]

              ;; Calculate the sum of elements to the left of the median in the current window
              ;; This corresponds to sum(median_q - q_s) for s < mid_idx_in_window
              [sum-left-elements
               (if (= mid-idx-in-window 0)
                   0
                   (- (list-ref prefix-q (+ i mid-idx-in-window - 1))
                      (if (> i 0) (list-ref prefix-q (- i 1)) 0)))]

              ;; Calculate the sum of elements to the right of the median in the current window
              ;; This corresponds to sum(q_s - median_q) for s > mid_idx_in_window
              [sum-right-elements
               (if (= mid-idx-in-window (- k 1)) ; If median is the last element in the window, there are no elements to its right
                   0
                   (- (list-ref prefix-q (+ i k - 1))
                      (list-ref prefix-q (+ i mid-idx-in-window))))]

              ;; Calculate the total cost for the current window using the formula:
              ;; sum(|q_s - median_q|) = (mid_idx_in_window * median_q - sum_left_elements) + (sum_right_elements - (count_right_elements * median_q))
              [current-cost
               (+ (- (* mid-idx-in-window median-q) sum-left-elements)
                  (- sum-right-elements (* (- k 1 mid-idx-in-window) median-q)))])
         (set! min-cost (min min-cost current-cost))))
     min-cost]))