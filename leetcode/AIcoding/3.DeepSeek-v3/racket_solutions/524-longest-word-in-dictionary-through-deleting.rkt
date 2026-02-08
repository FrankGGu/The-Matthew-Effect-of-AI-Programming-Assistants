(define/contract (find-longest-word s d)
  (-> string? (listof string?) string?)
  (define (is-subsequence? s word)
    (let loop ([i 0] [j 0])
      (cond
        [(= j (string-length word)) #t]
        [(= i (string-length s)) #f]
        [(char=? (string-ref s i) (string-ref word j))
         (loop (+ i 1) (+ j 1))]
        [else (loop (+ i 1) j)])))

  (define filtered (filter (lambda (word) (is-subsequence? s word)) d))

  (if (null? filtered)
      ""
      (car (sort filtered
                 (lambda (a b)
                   (or (> (string-length a) (string-length b))
                       (and (= (string-length a) (string-length b))
                            (string<? a b)))))))))