(define (minimum-array-changes-to-make-differences-equal nums)
  (let* ((n (vector-length nums)))
    (cond
      ((<= n 2) 0) ; For arrays of length 0, 1, or 2, 0 changes are always sufficient.
      (else
       (let ((max-count 1)) ; Initialize max-count to 1, as at least one element can always form an arithmetic progression.
         (for* ((i (in-range n))
                (j (in-range (+ i 1) n)))
           (let* ((delta-y-numerator (- (vector-ref nums j) (vector-ref nums i)))
                  (delta-y-denominator (- j i)))
             ;; Check if 'y' (common difference) is an integer
             (when (= (modulo delta-y-numerator delta-y-denominator) 0)
               (let* ((y (quotient delta-y-numerator delta-y-denominator))
                      (x (- (vector-ref nums i) (* i y))) ; Calculate 'x' (first term)
                      (current-count 0))
                 ;; Count how many elements match the arithmetic progression defined by x and y
                 (for ((k (in-range n)))
                   (when (= (vector-ref nums k) (+ x (* k y)))
                     (set! current-count (+ current-count 1))))
                 ;; Update max-count if current-count is higher
                 (set! max-count (max max-count current-count))))))
         ;; The minimum changes needed is total elements minus the maximum number of elements that already form an AP.
         (- n max-count))))))