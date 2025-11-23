(define (h-index-ii citations)
  (let* ((n (vector-length citations))
         (low 0)
         (high (if (zero? n) -1 (- n 1))) ; Adjust high for empty vector case
         (ans-idx n)) ; Initialize ans-idx to n. If no i satisfies condition, h-index is n - n = 0.
    (let loop ((l low) (h high) (current-ans-idx ans-idx))
      (if (> l h)
          (- n current-ans-idx)
          (let* ((mid (+ l (quotient (- h l) 2)))
                 (citation-val (vector-ref citations mid))
                 (num-papers-at-least-mid (- n mid)))
            (if (>= citation-val num-papers-at-least-mid)
                ; citations[mid] >= n - mid. This mid is a possible answer.
                ; We try to find an even smaller mid (which would give a larger n - mid).
                (loop l (- mid 1) mid)
                ; citations[mid] < n - mid. mid is too small. We need a larger mid.
                (loop (+ mid 1) h current-ans-idx)))))))