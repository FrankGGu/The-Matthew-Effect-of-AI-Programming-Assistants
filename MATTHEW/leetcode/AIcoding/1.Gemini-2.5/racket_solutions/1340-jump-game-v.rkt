#lang racket

(define (max-jumps arr d)
  (define n (vector-length arr))

  (define dp (make-vector n 1)) ; dp[i] = max jumps starting from index i

  ; Create a list of indices sorted by arr[i] in ascending order.
  ; This ensures that when we compute dp[i], all dp[j] values for j where arr[j] < arr[i]
  ; have already been computed and are final.
  (define sorted-indices
    (sort (build-list n identity)
          (lambda (idx1 idx2)
            (< (vector-ref arr idx1) (vector-ref arr idx2)))))

  ; Iterate through indices in ascending order of arr[i]
  (for-each
   (lambda (i)
     (let ((current-height (vector-ref arr i)))
       (let ((current-max-jumps (vector-ref dp i))) ; Initialize with 1 (for visiting the current index itself)

         ; Explore jumps to the right
         ; Iterate k from i+1 up to min(n-1, i+d)
         (for ((k (in-range (+ i 1) (min n (+ i d 1)))))
           (let ((k-height (vector-ref arr k)))
             ; If arr[k] is greater than or equal to arr[i],
             ; we cannot jump to k, nor can we jump over k to any further index.
             (when (>= k-height current-height)
               (break))
             ; If arr[k] < arr[i], then k is a valid jump target.
             ; Update current-max-jumps with 1 + dp[k].
             (set! current-max-jumps (max current-max-jumps (+ 1 (vector-ref dp k))))))

         ; Explore jumps to the left
         ; Iterate k from i-1 down to max(0, i-d)
         (for ((k (in-range (- i 1) (max -1 (- i d 1)) -1)))
           (let ((k-height (vector-ref arr k)))
             ; Similar logic for left jumps: if arr[k] blocks the path, break.
             (when (>= k-height current-height)
               (break))
             ; If arr[k] < arr[i], then k is a valid jump target.
             ; Update current-max-jumps with 1 + dp[k].
             (set! current-max-jumps (max current-max-jumps (+ 1 (vector-ref dp k))))))

         ; Store the maximum jumps found starting from index i
         (vector-set! dp i current-max-jumps))))
   sorted-indices)

  ; The final answer is the maximum value in the dp array
  (apply max (vector->list dp)))