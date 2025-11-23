(define/contract (find-lus-length strs)
  (-> (listof string?) exact-integer?)
  (define (is-subsequence? a b)
    (let loop ([i 0] [j 0])
      (cond
        [(= i (string-length a)) #t]
        [(= j (string-length b)) #f]
        [(char=? (string-ref a i) (string-ref b j)) (loop (+ i 1) (+ j 1))]
        [else (loop i (+ j 1))])))

  (let ([max-len -1])
    (for ([s1 (in-list strs)] [i (in-naturals)])
      (let ([is-uncommon #t])
        (for ([s2 (in-list strs)] [j (in-naturals)])
          (when (and (not (= i j)) (is-subsequence? s1 s2))
            (set! is-uncommon #f)
            (break)))
        (when is-uncommon
          (set! max-len (max max-len (string-length s1))))))
    max-len))