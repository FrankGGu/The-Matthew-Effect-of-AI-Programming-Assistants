(define (largest-combination candidates)
  (let loop ((bit-pos 0) (max-count 0))
    (if (> bit-pos 30)
        max-count
        (let ((current-bit-mask (arithmetic-shift 1 bit-pos)))
          (let ((count-for-this-bit
                 (for/sum ((num candidates))
                   (if (> (bitwise-and num current-bit-mask) 0)
                       1
                       0))))
            (loop (+ bit-pos 1) (max max-count count-for-this-bit)))))))