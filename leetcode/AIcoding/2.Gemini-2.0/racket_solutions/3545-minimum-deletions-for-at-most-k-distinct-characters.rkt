(define (min-deletions s k)
  (let* ([n (string-length s)]
         [freq (make-hash)]
         [_ (for ([i (in-range n)])
              (hash-update! freq (string-ref s i) add1 0))]
         [freq-list (sort (hash-values freq) >)]
         [len (length freq-list)])
    (if (<= len k)
        0
        (let loop ([i k] [total (apply + (drop freq-list k))])
          (if (= i len)
              total
              (loop (+ 1 i) (- total (list-ref freq-list i))))))))