(define (kth-largest-value matrix k)
  (let* ([m (length matrix)]
         [n (length (car matrix))]
         [xor-vals (make-vector (* m n) 0)]
         [prefix-xor (make-vector (* m n) 0)])
    (for ([i (in-range m)])
      (for ([j (in-range n)])
        (let ([idx (+ (* i n) j)])
          (set! (vector-ref prefix-xor idx)
                (cond
                  [(and (= i 0) (= j 0)) (list-ref (list-ref matrix i) j)]
                  [(and (= i 0) (> j 0)) (bitwise-xor (list-ref (list-ref matrix i) j) (vector-ref prefix-xor (+ (* i n) (- j 1))))]
                  [(and (> i 0) (= j 0)) (bitwise-xor (list-ref (list-ref matrix i) j) (vector-ref prefix-xor (+ (* (- i 1) n) j)))]
                  [else (bitwise-xor (list-ref (list-ref matrix i) j) (bitwise-xor (vector-ref prefix-xor (+ (* (- i 1) n) j)) (bitwise-xor (vector-ref prefix-xor (+ (* i n) (- j 1))) (vector-ref prefix-xor (+ (* (- i 1) n) (- j 1))))))]
                  ))
          (set! (vector-ref xor-vals idx) (vector-ref prefix-xor idx))))
    (sort (vector->list xor-vals) > #:cache-keys? #f)
    (list-ref (sort (vector->list xor-vals) > #:cache-keys? #f) (- k 1))))