(define (check-non-decreasing nums-list)
  (let* ([n (length nums-list)]
         [nums (list->vector nums-list)]) ; Convert list to mutable vector for O(1) access/modification
    (let loop ([i 0] [violations 0])
      (cond
        [(>= i (- n 1)) ; Base case: iterated through all pairs
         (<= violations 1)]
        [(> (vector-ref nums i) (vector-ref nums (+ i 1))) ; Violation found
         (let ([new-violations (+ violations 1)])
           (if (> new-violations 1)
               #f ; More than one violation, impossible
               (begin
                 ; Decide which element to modify to fix the current violation
                 ; If nums[i-1] > nums[i+1], we cannot decrease nums[i]
                 ; because it would create a new violation with nums[i-1].
                 ; In this case, we must increase nums[i+1] to nums[i].
                 (if (and (> i 0) (> (vector-ref nums (- i 1)) (vector-ref nums (+ i 1))))
                     (vector-set! nums (+ i 1) (vector-ref nums i)) ; Increase nums[i+1]
                     (vector-set! nums i (vector-ref nums (+ i 1)))) ; Decrease nums[i] (preferred or only option if i=0)
                 ; Continue to next iteration after modification
                 (loop (+ i 1) new-violations))))]
        [else ; No violation, continue iteration
         (loop (+ i 1) violations)]))))