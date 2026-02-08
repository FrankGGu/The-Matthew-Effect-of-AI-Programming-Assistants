(define (permutation-difference s t)
  (let* ([n (string-length s)]
         [t-char-indices (make-hash)])
    (for ([i (in-range n)])
      (hash-set! t-char-indices (string-ref t i) i))
    (for/sum ([i (in-range n)])
      (let* ([s-char (string-ref s i)]
             [t-char-idx (hash-ref t-char-indices s-char)])
        (abs (- i t-char-idx))))))