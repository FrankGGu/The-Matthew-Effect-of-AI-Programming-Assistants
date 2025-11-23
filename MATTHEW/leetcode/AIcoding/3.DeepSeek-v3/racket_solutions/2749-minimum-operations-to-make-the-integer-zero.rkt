(define/contract (make-the-integer-zero num1 num2)
  (-> exact-integer? exact-integer? exact-integer?)
  (let loop ((k 1))
    (let ((diff (- num1 (* k num2))))
      (cond
        [(< diff k) -1]
        [(<= (bitwise-bit-count diff) k) k]
        [else (loop (add1 k))]))))