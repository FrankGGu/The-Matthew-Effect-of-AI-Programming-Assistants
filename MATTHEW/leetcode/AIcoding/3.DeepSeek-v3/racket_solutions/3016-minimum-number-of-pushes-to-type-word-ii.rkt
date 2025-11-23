(define/contract (minimum-pushes word)
  (-> string? exact-integer?)
  (let* ([freqs (make-hash)]
         [len (string-length word)])
    (for ([i (in-range len)])
      (let ([c (string-ref word i)])
        (hash-update! freqs c add1 0)))
    (let* ([sorted-freqs (sort (hash->list freqs) 
                              (lambda (a b) (> (cdr a) (cdr b))))]
           [pushes 0]
           [positions 8])
      (for ([i (in-range (length sorted-freqs))])
        (let* ([pair (list-ref sorted-freqs i)]
               [freq (cdr pair)]
               [cost (quotient i positions)])
          (set! pushes (+ pushes (* freq (+ cost 1))))))
      pushes)))