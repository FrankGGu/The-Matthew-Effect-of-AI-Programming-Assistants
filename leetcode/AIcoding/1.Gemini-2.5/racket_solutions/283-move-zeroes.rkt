(define (move-zeroes nums)
  (let* ([n (vector-length nums)]
         [non-zero-ptr 0])
    ;; First pass: move all non-zero elements to the front
    (for ([i (in-range n)])
      (when (not (= (vector-ref nums i) 0))
        (vector-set! nums non-zero-ptr (vector-ref nums i))
        (set! non-zero-ptr (+ non-zero-ptr 1))))

    ;; Second pass: fill the rest of the vector with zeros
    (for ([i (in-range non-zero-ptr n)])
      (vector-set! nums i 0))

    (void)))