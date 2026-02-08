(define/contract (min-operations s)
  (-> string? exact-integer?)
  (let* ([freqs (make-hash)]
         [len (string-length s)])
    (for ([c s])
      (hash-update! freqs c add1 0))
    (let ([counts (hash-values freqs)]
          [res 0])
      (set! counts (sort counts >))
      (let loop ([i 1] [prev (car counts)])
        (when (< i (length counts))
          (let ([curr (list-ref counts i)])
            (cond
              [(>= curr prev)
               (let ([diff (add1 (- curr prev))])
                 (set! res (+ res diff))
                 (loop (add1 i) (- prev diff)))]
              [else
               (loop (add1 i) curr)]))))
      res)))