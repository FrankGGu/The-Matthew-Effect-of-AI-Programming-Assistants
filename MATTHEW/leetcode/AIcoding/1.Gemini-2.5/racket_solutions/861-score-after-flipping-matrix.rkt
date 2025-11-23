(define (matrix-score grid)
  (let* ((R (length grid))
         (C (length (car grid)))
         (total-score 0))

    ;; Handle the first column (most significant bit)
    ;; All first elements should be 1. This contributes (expt 2 (- C 1)) for each row.
    (set! total-score (* R (expt 2 (- C 1))))

    ;; Handle subsequent columns (j from 1 to C-1)
    (for ((j (range 1 C)))
      (let ((current-column-ones 0))
        (for ((i (range R)))
          (let* ((row (list-ref grid i))
                 (first-element (list-ref row 0))
                 (current-element-at-j (list-ref row j)))
            (let ((effective-value-at-i-j
                   (if (= first-element 0)
                       (- 1 current-element-at-j) ; Row was flipped
                       current-element-at-j)))    ; Row was not flipped
              (when (= effective-value-at-i-j 1)
                (set! current-column-ones (+ current-column-ones 1))))))

        ;; Decide whether to flip this column to maximize 1s.
        ;; The number of 1s in this column will be max(current-column-ones, R - current-column-ones).
        (let ((ones-to-add (max current-column-ones (- R current-column-ones))))
          (set! total-score (+ total-score (* ones-to-add (expt 2 (- C 1 j)))))))))
    total-score))