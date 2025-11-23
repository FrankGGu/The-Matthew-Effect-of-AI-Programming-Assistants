(define (k-th-symbol-in-grammar n k)
  (if (= n 1)
      0
      (if (even? k)
          (if (= (k-th-symbol-in-grammar (- n 1) (/ k 2)) 0) 1 0)
          (if (= (k-th-symbol-in-grammar (- n 1) (/ (+ k 1) 2)) 0) 0 1))))

(define (kthSymbol n k)
  (k-th-symbol-in-grammar n k))