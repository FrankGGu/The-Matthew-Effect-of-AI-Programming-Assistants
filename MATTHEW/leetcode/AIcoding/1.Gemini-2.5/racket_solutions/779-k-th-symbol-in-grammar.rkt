(define (kth-grammar N K)
  (if (= N 1)
      0
      (let* ((prev-k (quotient (+ K 1) 2))
             (prev-symbol (kth-grammar (- N 1) prev-k)))
        (if (= (remainder K 2) 1) ; K is odd
            prev-symbol
            (if (= prev-symbol 0) ; K is even, invert prev-symbol
                1
                0)))))