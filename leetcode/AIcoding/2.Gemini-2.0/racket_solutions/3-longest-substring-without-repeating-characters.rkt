(define (length-of-longest-substring s)
  (let loop ([i 0] [j 0] [max-len 0] [seen (hash)])
    (cond
      [(>= j (string-length s)) max-len]
      [else
       (let ([char (string-ref s j)])
         (if (hash-has-key? seen char)
             (let ([new-i (add1 (hash-ref seen char))])
               (let loop2 ([k i])
                 (cond
                   [(< k new-i)
                    (hash-remove! seen (string-ref s k))
                    (loop2 (add1 k))]
                   [else
                    (hash-set! seen char j)
                    (loop (max new-i i) (add1 j) (max max-len (- (add1 j) (max new-i i))) seen)])))
             (begin
               (hash-set! seen char j)
               (loop i (add1 j) (max max-len (+ 1 (- j i))) seen))))])))