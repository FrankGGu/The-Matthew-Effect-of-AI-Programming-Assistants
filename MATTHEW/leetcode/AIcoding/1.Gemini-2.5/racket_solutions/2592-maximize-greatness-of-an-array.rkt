(define (maximize-greatness nums)
  (let* ([n (length nums)]
         [sorted-nums (sort nums <)]
         [nums-vec (list->vector sorted-nums)])
    (let loop ([i 0] ; Pointer for the element to be matched (smaller)
               [j 0] ; Pointer for the potential matching element (greater)
               [greatness 0])
      (cond
        [(>= j n) greatness] ; All possible greater elements have been considered
        [else
         (let ([num-i (vector-ref nums-vec i)]
               [num-j (vector-ref nums-vec j)])
           (if (< num-i num-j)
               ; If nums[i] < nums[j], we found a valid pair.
               ; Increment greatness, and advance both pointers.
               (loop (+ i 1) (+ j 1) (+ greatness 1))
               ; If nums[i] >= nums[j], nums[j] cannot be greater than nums[i].
               ; Advance only j to find a larger element for current nums[i].
               (loop i (+ j 1) greatness)))]))))