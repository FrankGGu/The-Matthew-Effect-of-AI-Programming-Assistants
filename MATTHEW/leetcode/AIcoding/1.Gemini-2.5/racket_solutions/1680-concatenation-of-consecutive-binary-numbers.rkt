(define (concatenatedBinary n)
  (let ([MOD 1000000007])
    (let loop ([i 1] [res 0])
      (if (> i n)
          res
          (let* ([len (integer-length i)]
                 [shifted-res (modulo (* res (expt 2 len)) MOD)]
                 [new-res (modulo (+ shifted-res i) MOD)])
            (loop (+ i 1) new-res))))))