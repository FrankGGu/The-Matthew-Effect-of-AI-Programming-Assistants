(define (get-max-len nums)
  (define-values (overall-max-len current-pos-len current-neg-len)
    (for/fold
        ((overall-max-len 0)
         (current-pos-len 0)
         (current-neg-len 0))
        ((n (in-list nums)))
      (cond
        ((> n 0)
         (values
          (max overall-max-len (+ current-pos-len 1))
          (+ current-pos-len 1)
          (if (> current-neg-len 0) (+ current-neg-len 1) 0)))
        ((< n 0)
         (define temp-pos-len current-pos-len)
         (define new-pos-len (if (> current-neg-len 0) (+ current-neg-len 1) 0))
         (values
          (max overall-max-len new-pos-len)
          new-pos-len
          (+ temp-pos-len 1)))
        (else ; n == 0
         (values
          overall-max-len
          0
          0))))
  overall-max-len))