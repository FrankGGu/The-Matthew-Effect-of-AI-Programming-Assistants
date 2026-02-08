(define (count-numbers-with-unique-digits n)
  (cond
    ((= n 0) 1)
    (else
     (let loop ((k 1) ; current number of digits (from 1 to n)
                (total-count 1) ; total count so far (starts with 1 for the number 0)
                (permutations-count 1)) ; count of permutations for (k-1) digits unique numbers (used to calculate for k digits)
       (if (> k n)
           total-count
           (let* ((new-permutations-count
                   (if (= k 1)
                       9 ; For k=1, 9 choices (1-9) for the first digit. (0 is handled by total-count = 1)
                       (* permutations-count (- 11 k))))) ; For k>1, multiply by (10 - (k-1)) available digits.
                                                          ; This is (11 - k)
                  (next-total-count (+ total-count new-permutations-count)))
             (loop (+ k 1)
                   next-total-count
                   new-permutations-count)))))))