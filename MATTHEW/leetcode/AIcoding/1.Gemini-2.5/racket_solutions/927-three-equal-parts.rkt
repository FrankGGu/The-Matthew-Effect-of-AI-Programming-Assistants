#lang racket

(define (three-equal-parts A)
  (let* ([n (length A)]
         [total-ones (for/sum ([x A]) x)])

    (cond
      ;; Case 1: Total number of ones is not divisible by 3
      [(not (= (remainder total-ones 3) 0))
       (list -1 -1)]

      ;; Case 2: No ones in the array (all zeros)
      [(= total-ones 0)
       ;; Any split where 0 <= i < j < n will result in three parts
       ;; that all represent the binary value 0.
       ;; The problem constraints state n >= 3, so n-2 >= 1.
       ;; [0, n-2] is a valid split: A[0...0], A[1...n-2], A[n-1...n-1].
       (list 0 (- n 2))]

      ;; Case 3: Total ones > 0 and divisible by 3
      [else
       (let* ([k (/ total-ones 3)]
              ;; Get all indices where A[idx] is 1
              [one-indices (for/list ([val A] [idx (in-naturals)] #:when (= val 1)) idx)]

              ;; Find the indices of the 1st, k-th, (k+1)-th, (2k)-th, (2k+1)-th, (3k)-th ones.
              ;; These are 0-indexed positions within the 'one-indices' list.
              [idx1 (list-ref one-indices 0)]
              [idx2 (list-ref one-indices (- k 1))]
              [idx3 (list-ref one-indices k)]
              [idx4 (list-ref one-indices (- (* 2 k) 1))]
              [idx5 (list-ref one-indices (* 2 k))]
              [idx6 (list-ref one-indices (- (* 3 k) 1))]

              ;; Calculate the number of trailing zeros after the last '1' in the entire array.
              ;; This number of trailing zeros must be present in all three parts.
              [trailing-zeros-count (- n 1 idx6)]

              ;; Determine the end indices for the first and second parts.
              ;; Each part must contain its 'core' binary sequence (from its first '1' to its last '1')
              ;; followed by 'trailing-zeros-count' zeros.
              [i-end (+ idx2 trailing-zeros-count)]
              [j-end (+ idx4 trailing-zeros-count)])

         ;; Check if the 'core' lengths of the three parts are equal.
         ;; The 'core' is the segment from the first '1' to the last '1' within each part.
         (let ([len-core1 (- idx2 idx1)]
               [len-core2 (- idx4 idx3)]
               [len-core3 (- idx6 idx5)])
           (if (or (not (= len-core1 len-core2)) (not (= len-core2 len-core3)))
               (list -1 -1) ; Core lengths mismatch, cannot form equal parts

               ;; Now, perform detailed checks on the content of the parts.
               ;; This includes comparing the 'core' binary sequences and ensuring
               ;; the necessary trailing zeros are present.
               (let check-parts ([offset 0])
                 (cond
                   ;; Phase 1: Check the 'core' content of the three parts.
                   ;; Compare A[idx1+offset], A[idx3+offset], A[idx5+offset].
                   [(< offset (+ len-core1 1)) ; (+ len-core1 1) is the length of the core segment (inclusive)
                    (let ([val1 (list-ref A (+ idx1 offset))]
                          [val2 (list-ref A (+ idx3 offset))]
                          [val3 (list-ref A (+ idx5 offset))])
                      (if (or (not (= val1 val2)) (not (= val2 val3)))
                          (list -1 -1) ; Core content mismatch
                          (check-parts (+ offset 1))))]

                   ;; Phase 2: Check the required trailing zeros for the first two parts.
                   ;; A[idx2+1 ... i-end] and A[idx4+1 ... j-end] must all be zeros.
                   [(< (- offset (+ len-core1 1)) trailing-zeros-count)
                    (let ([z-offset (- offset (+ len-core1 1))] ; Relative offset for trailing zeros
                          [val1 (list-ref A (+ idx2 1 z-offset))]
                          [val2 (list-ref A (+ idx4 1 z-offset))])
                      (if (or (= val1 1) (= val2 1))
                          (list -1 -1) ; Found a '1' where a '0' was expected (trailing zeros mismatch)
                          (check-parts (+ offset 1))))]

                   ;; All checks passed, return the valid indices [i-end, j-end].
                   [else
                    (list i-end j-end)])))))])))