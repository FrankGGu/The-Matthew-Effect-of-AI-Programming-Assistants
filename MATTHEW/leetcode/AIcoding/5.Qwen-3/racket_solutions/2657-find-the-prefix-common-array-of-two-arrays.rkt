(define (common-two-array a b)
  (let ([n (length a)])
    (let loop ([i 0] [mask1 0] [mask2 0] [result '()])
      (if (= i n)
          (reverse result)
          (let* ([val1 (list-ref a i)]
                 [val2 (list-ref b i)]
                 [mask1 (bitwise-ior mask1 (arithmetic-shift 1 val1))]
                 [mask2 (bitwise-ior mask2 (arithmetic-shift 1 val2))]
                 [count (bitwise-bit-count (bitwise-and mask1 mask2))])
            (loop (+ i 1) mask1 mask2 (cons count result)))))))