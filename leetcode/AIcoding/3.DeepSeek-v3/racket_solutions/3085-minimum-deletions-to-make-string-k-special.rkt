(define/contract (minimum-deletions s k)
  (-> string? exact-integer? exact-integer?)
  (let* ([freq (make-hash)]
         [n (string-length s)])
    (for ([i (in-range n)])
      (let ([c (string-ref s i)])
        (hash-update! freq c add1 (lambda () 0))))
    (let* ([freq-list (sort (hash-values freq) >)]
           [m (length freq-list)]
           [res +inf.0])
      (for ([i (in-range m)])
        (let ([target (list-ref freq-list i)]
              [deletions 0])
          (for ([j (in-range m)])
            (let ([freq-j (list-ref freq-list j)])
              (if (<= freq-j target)
                  (set! deletions (+ deletions (- freq-j target)))
                  (set! deletions (+ deletions freq-j)))))
          (when (< deletions res)
            (set! res deletions))))
      (exact-round res))))