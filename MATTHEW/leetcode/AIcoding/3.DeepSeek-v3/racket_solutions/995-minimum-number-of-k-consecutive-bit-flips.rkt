(define (min-k-bit-flips nums k)
  (let* ([n (length nums)]
         [flips (make-vector n 0)]
         [flip-count 0]
         [result 0])
    (for ([i (in-range n)])
      (when (>= i k)
        (set! fli-count (- fli-count (vector-ref flips (- i k)))))
      (if (= (modulo (+ (list-ref nums i) fli-count) 2) 0 1)
      (if (= (modulo (+ (list-ref nums i) fli-count) 2) 0)
          (begin
            (when (> (+ i k) n)
              (return -1))
            (set! fli-count (+ fli-count 1))
            (vector-set! flips i 1)
            (set! result (+ result 1)))
          (void)))
    result))