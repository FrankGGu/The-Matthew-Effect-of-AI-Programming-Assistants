(define (find-length-of-shortest-subarray arr-list)
  (let* ((n (length arr-list))
         (arr (list->vector arr-list)))

    (cond
      ((<= n 1) 0) ; Base case: 0 or 1 element, already sorted
      (else
       ;; 1. Find 'left': end of longest non-decreasing prefix
       (define left 0)
       (let loop-left ()
         (when (and (< (+ left 1) n)
                    (<= (vector-ref arr left) (vector-ref arr (+ left 1))))
           (set! left (+ left 1))
           (loop-left)))

       ;; If the entire array is sorted, no removal needed
       (if (= left (- n 1))
           0
           (let ()
             ;; 2. Find 'right': start of longest non-decreasing suffix
             (define right (- n 1))
             (let loop-right ()
               (when (and (>= (- right 1) 0)
                          (<= (vector-ref arr (- right 1)) (vector-ref arr right)))
                 (set! right (- right 1))
                 (loop-right)))

             ;; 3. Initialize min-removed
             ;; Case 1: Remove suffix arr[left+1 ... n-1]
             (define min-removed (- n (+ left 1)))
             ;; Case 2: Remove prefix arr[0 ... right-1]
             (set! min-removed (min min-removed right))

             ;; 4. Two pointers for combined prefix and suffix
             (define i 0)
             (define j right)

             (let loop-pointers ()
               (when (and (<= i left) (< j n))
                 (if (<= (vector-ref arr i) (vector-ref arr j))
                     (begin
                       ;; Remove subarray arr[i+1 ... j-1]
                       (set! min-removed (min min-removed (max 0 (- (- j i) 1))))
                       (set! i (+ i 1)))
                     (set! j (+ j 1)))
                 (loop-pointers)))

             min-removed))))))