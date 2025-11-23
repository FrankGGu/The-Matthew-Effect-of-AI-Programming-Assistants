(define (minimum-array-length-after-pair-removals nums)
  (let* ([n (length nums)]
         [sorted-nums (sort nums <)])
    (if (< n 2)
        n ; If less than 2 elements, no pairs can be removed.
        (let loop ([i 0]
                   [j (quotient n 2)]
                   [removed-pairs 0])
          (if (or (>= i (quotient n 2)) (>= j n))
              (- n (* 2 removed-pairs)) ; All possible pairs considered
              (let ([val-i (list-ref sorted-nums i)]
                    [val-j (list-ref sorted-nums j)])
                (if (< val-i val-j)
                    ; Found a pair: nums[i] < nums[j]. Remove both.
                    ; Move to the next smallest element in the first half (i+1)
                    ; and the next smallest available element in the second half (j+1).
                    (loop (+ i 1) (+ j 1) (+ removed-pairs 1))
                    ; Cannot form a pair with val-i and val-j because val-i >= val-j.
                    ; Since sorted, val-j is too small for val-i (and any subsequent elements in the first half).
                    ; So, val-j cannot be used. We must try a larger element from the second half for val-i.
                    ; Keep i the same, and move to the next element in the second half (j+1).
                    (loop i (+ j 1) removed-pairs))))))))