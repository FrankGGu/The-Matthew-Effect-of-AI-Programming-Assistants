(define (count-subarrays-with-fixed-bounds nums minK maxK)
  (let* ((n (vector-length nums)))
    (for/fold ((total 0)
               (start-idx 0)
               (last-minK-idx -1)
               (last-maxK-idx -1))
              ((i (in-range n)))
      (let ((num (vector-ref nums i)))
        (cond
          ((or (< num minK) (> num maxK))
           (values total
                   (+ i 1)
                   -1
                   -1))
          (else
           (let* ((new-last-minK-idx (if (= num minK) i last-minK-idx))
                  (new-last-maxK-idx (if (= num maxK) i last-maxK-idx))
                  (effective-start-of-valid-range (min new-last-minK-idx new-last-maxK-idx)))
             (values (+ total (max 0 (- effective-start-of-valid-range start-idx + 1)))
                     start-idx
                     new-last-minK-idx
                     new-last-maxK-idx))))))))