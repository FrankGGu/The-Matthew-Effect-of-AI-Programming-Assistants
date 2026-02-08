(define (concatenated-binary n)
  (define MOD 1000000007)
  (let loop ((i 1) (res 0))
    (if (> i n)
        res
        (let* ((num-bits (integer-length i))
               (shifted-res (modulo (* res (expt 2 num-bits)) MOD))
               (new-res (modulo (+ shifted-res i) MOD)))
          (loop (+ i 1) new-res)))))