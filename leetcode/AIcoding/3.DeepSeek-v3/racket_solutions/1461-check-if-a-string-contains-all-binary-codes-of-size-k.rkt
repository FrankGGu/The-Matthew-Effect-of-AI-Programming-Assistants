(define/contract (has-all-codes s k)
  (-> string? exact-integer? boolean?)
  (let* ([n (string-length s)]
         [required (expt 2 k)]
         [seen (make-hash)])
    (if (< n (+ k (- required 1)))
        #f
        (begin
          (for ([i (in-range 0 (+ (- n k) 1))])
            (let ([sub (substring s i (+ i k))])
              (hash-set! seen sub #t)))
          (= (hash-count seen) required)))))