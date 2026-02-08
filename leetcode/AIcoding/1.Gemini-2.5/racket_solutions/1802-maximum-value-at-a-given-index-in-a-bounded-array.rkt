(define (maximum-value-at-given-index n index max-sum)

  (define (get-side-sum peak-val num-elements)
    (if (<= num-elements 0)
        0
        (let ((val-minus-1 (- peak-val 1)))
          (if (>= val-minus-1 num-elements)
              ;; Case 1: Enough values to decrease without hitting 1
              ;; Sum of an arithmetic progression: (peak-val-1) down to (peak-val-1 - num-elements + 1)
              ;; Sum = count * (first + last) / 2
              ;; Simplified: num-elements * peak-val - sum(1 to num-elements)
              (- (* num-elements peak-val)
                 (quotient (* num-elements (+ num-elements 1)) 2))
              ;; Case 2: Hit 1, then some 1s
              ;; Sum of 1 to (peak-val-1) is (peak-val-1 * peak-val) / 2
              ;; Plus (num-elements - (peak-val-1)) ones
              (+ (quotient (* val-minus-1 (+ val-minus-1 1)) 2)
                 (- num-elements val-minus-1))))))

  (define (check x)
    (let* ((left-len index)
           (right-len (- n 1 index))
           (current-sum x)
           (left-side-sum (get-side-sum x left-len))
           (right-side-sum (get-side-sum x right-len)))
      (<= (+ current-sum left-side-sum right-side-sum) max-sum)))

  (let loop ((low 1) (high max-sum) (ans 0))
    (if (> low high)
        ans
        (let* ((mid (quotient (+ low high) 2)))
          (if (check mid)
              (loop (+ mid 1) high mid)
              (loop low (- mid 1) ans))))))