(define (mct-from-leaf-values arr)
  (let* ((stack (list 16)) ; Sentinel value, larger than any possible arr[i] (1 <= arr[i] <= 15)
         (ans 0))

    (for ((x (in-list arr)))
      (let loop ()
        (when (and (not (null? (cdr stack))) ; Ensures there's at least one element below the top (excluding sentinel)
                   (>= x (car stack)))
          (let ((mid (car stack)))
            (set! stack (cdr stack)) ; Pop mid element
            (set! ans (+ ans (* mid (min (car stack) x))))
            (loop)))) ; Continue popping if x is still greater than or equal to the new top
      (set! stack (cons x stack))) ; Push x onto the stack

    ;; After iterating through all elements in arr, process remaining elements in the stack.
    ;; The stack will be monotonic decreasing, with the sentinel at the bottom.
    ;; We combine elements until only the sentinel and one actual element remain.
    (let loop ()
      (when (> (length stack) 2) ; While stack has more than 2 elements (sentinel + at least two actual elements)
        (let ((val1 (car stack)))
          (set! stack (cdr stack))
          (let ((val2 (car stack)))
            (set! ans (+ ans (* val1 val2)))
            (loop)))))
    ans))