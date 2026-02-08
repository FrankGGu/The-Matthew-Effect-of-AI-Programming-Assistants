(define/contract (minimize-xor num1 num2)
  (-> exact-integer? exact-integer? exact-integer?)
  (let* ([count (bitwise-bit-count num2)]
         [mask 1]
         [res 0])
    (for ([i (in-range 31 -1 -1)])
      (when (positive? count)
        (if (positive? (bitwise-and num1 (arithmetic-shift mask i)))
            (begin
              (set! res (bitwise-ior res (arithmetic-shift mask i)))
              (set! count (sub1 count)))
            (void)))
    (for ([i (in-range 0 32)])
      (when (positive? count)
        (if (zero? (bitwise-and num1 (arithmetic-shift mask i)))
            (begin
              (set! res (bitwise-ior res (arithmetic-shift mask i)))
              (set! count (sub1 count)))
            (void)))
    res))