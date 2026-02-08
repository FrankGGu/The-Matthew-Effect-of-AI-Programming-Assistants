(define/contract (num-matching-subseq s words)
  (-> string? (listof string?) exact-integer?)
  (define (is-subsequence? word s)
    (let loop ([i 0] [j 0])
      (cond
        [(= j (string-length word)) #t]
        [(= i (string-length s)) #f]
        [(char=? (string-ref word j) (string-ref s i)) (loop (+ i 1) (+ j 1))]
        [else (loop (+ i 1) j)])))
  (count is-subsequence? words s))