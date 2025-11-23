(define (mct-from-leaf-values arr)
  (let* ([n (length arr)]
         [arr-vec (list->vector arr)]
         [dp (make-vector n (lambda () (make-vector n 0)))]
         [max-val (make-vector n (lambda () (make-vector n 0)))])

    ;; Precompute max-val[i][j] for all subarrays arr[i...j]
    (for ([i (in-range n)])
      (vector-set! (vector-ref max-val i) i (vector-ref arr-vec i))
      (for ([j (in-range (+ i 1) n)])
        (vector-set! (vector-ref max-val i) j
                     (max (vector-ref (vector-ref max-val i) (- j 1))
                          (vector-ref arr-vec j)))))

    ;; Initialize dp[i][i] to 0 (single leaf node has no non-leaf cost)
    (for ([i (in-range n)])
      (vector-set! (vector-ref dp i) i 0))

    ;; Fill dp table for increasing subarray lengths
    (for ([len (in-range 2 (+ n 1))]) ; len from 2 to n
      (for ([i (in-range 0 (- n len 0))]) ; i from 0 to n - len
        (let ([j (+ i len -1)])
          (vector-set! (vector-ref dp i) j +inf.0) ; Initialize with infinity
          ;; Try all possible split points k
          (for ([k (in-range i j)]) ; k from i to j-1
            (let ([cost (+ (+ (vector-ref (vector-ref dp i) k)
                              (vector-ref (vector-ref dp (+ k 1)) j))
                           (* (vector-ref (vector-ref max-val i) k)
                              (vector-ref (vector-ref max-val (+ k 1)) j)))])
              (when (< cost (vector-ref (vector-ref dp i) j))
                (vector-set! (vector-ref dp i) j cost)))))))

    ;; The result is the minimum cost for the entire array arr[0...n-1]
    (vector-ref (vector-ref dp 0) (- n 1))))