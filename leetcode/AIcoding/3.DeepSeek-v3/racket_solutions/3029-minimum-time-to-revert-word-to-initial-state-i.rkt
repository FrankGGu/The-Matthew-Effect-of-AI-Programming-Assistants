(define/contract (minimum-time-to-revert-word initial k)
  (-> string? exact-integer? exact-integer?)
  (let loop ([t 1])
    (let ([prefix-len (* k t)])
      (if (>= prefix-len (string-length initial))
          1
          (let ([prefix (substring initial 0 (- (string-length initial) prefix-len))]
                [suffix (substring initial prefix-len)])
            (if (string=? prefix suffix)
                t
                (loop (add1 t)))))))