(define (check-if-matrix-is-x-matrix grid)
  (let* ((n (length grid)))
    (for/and ((r (in-range n)))
      (for/and ((c (in-range n)))
        (let ((val (list-ref (list-ref grid r) c)))
          (if (or (= r c) (= (+ r c) (- n 1))) ; On a diagonal
              (not (= val 0))                  ; Must be non-zero
              (= val 0)))))))                  ; Must be zero