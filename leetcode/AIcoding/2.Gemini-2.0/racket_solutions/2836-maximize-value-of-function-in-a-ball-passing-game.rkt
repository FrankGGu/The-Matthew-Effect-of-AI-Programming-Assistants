(define (max-value-of-function n nums)
  (let* ([log-n (integer-length n)]
         [dp (make-vector (+ log-n 1) (make-vector n 0))]
         [sums (make-vector n 0)])
    (for ([i (in-range n)])
      (vector-set! (vector-ref dp 0) i (vector-ref nums i)))
    (for ([i (in-range 1 (+ log-n 1))])
      (for ([j (in-range n)])
        (vector-set! (vector-ref dp i) j (vector-ref (vector-ref dp (- i 1)) (vector-ref (vector-ref dp (- i 1)) j)))))

    (let loop ([i 0] [curr 0] [k n] [sum 0])
      (cond
        [(= k 0) sum]
        [else
         (let* ([bit (bitwise-and k 1)]
                [next-curr (if (= bit 1) (vector-ref (vector-ref dp i) curr) curr)]
                [next-sum (if (= bit 1) (+ sum curr) sum)]
                [next-k (arithmetic-shift k -1)]
                [next-i (+ i 1)])
           (loop next-i next-curr next-k next-sum))])))