(define (next-greater-elements nums)
  (let* ([n (vector-length nums)]
         [result (make-vector n -1)]
         [stack '()]) ; Stores indices, with the top of the stack at (car stack)

    (for ([i (in-range (* 2 n))])
      (let* ([current-idx (modulo i n)]
             [current-val (vector-ref nums current-idx)])

        ; Pop elements from the stack that are smaller than current-val
        (let pop-loop ()
          (when (and (not (null? stack))
                     (< (vector-ref nums (car stack)) current-val))
            (vector-set! result (car stack) current-val)
            (set! stack (cdr stack)) ; Pop the top element
            (pop-loop))) ; Continue popping until stack is empty or top is greater/equal

        ; Push current-idx onto the stack only if it's from the first pass
        ; (i.e., we are processing an original element for the first time
        ; and it might need a next greater element from the circular part)
        (when (< i n)
          (set! stack (cons current-idx stack))))) ; Push current_idx

    result))