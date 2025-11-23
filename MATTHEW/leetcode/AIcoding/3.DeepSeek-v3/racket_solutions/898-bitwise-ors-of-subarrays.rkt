(define (subarray-bitwise-ors arr)
  (let loop ([i 0] [res (set)] [cur (set)])
    (if (>= i (vector-length arr))
        (set-count res)
        (let* ([new-cur (set)]
               [x (vector-ref arr i)]
               [new-cur (set-add new-cur x)]
               [new-cur (for/fold ([s new-cur]) ([num (in-set cur)])
                          (set-add s (bitwise-ior num x)))])
          (loop (add1 i) (set-union res new-cur) new-cur)))))