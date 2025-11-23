(define (min-deletions-to-make-array-beautiful nums)
  (let loop ((idx 0)
             (beautiful-length 0)
             (last-beautiful-val -1) ; Sentinel value, will be updated before first comparison
             (deletions 0))
    (if (>= idx (length nums))
        ; Base case: all numbers processed
        (if (odd? beautiful-length)
            ; If the final beautiful-length is odd, we must delete the last element
            (add1 deletions)
            deletions)
        ; Recursive step
        (let ((current-num (list-ref nums idx)))
          (if (even? beautiful-length)
              ; Case 1: The beautiful array being built has an even length.
              ; The current number will be at an even index. Always add it.
              (loop (add1 idx)
                    (add1 beautiful-length)
                    current-num
                    deletions)
              ; Case 2: The beautiful array being built has an odd length.
              ; The current number will be at an odd index. Check condition.
              (if (= current-num last-beautiful-val)
                  ; Condition violated (nums[i] == nums[i+1]), delete current-num.
                  (loop (add1 idx)
                        beautiful-length
                        last-beautiful-val
                        (add1 deletions))
                  ; Condition met (nums[i] != nums[i+1]), add current-num.
                  (loop (add1 idx)
                        (add1 beautiful-length)
                        current-num
                        deletions)))))))