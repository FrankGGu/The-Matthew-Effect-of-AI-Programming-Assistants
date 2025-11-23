(define (are-sentence-similar sentence1 sentence2)
  (define (split-string s)
    (string-split s))
  (define words1 (split-string sentence1))
  (define words2 (split-string sentence2))
  (let loop ([i 0]
             [j 0]
             [n (length words1)]
             [m (length words2)])
    (cond
      [(and (< i n) (< j m) (string=? (list-ref words1 i) (list-ref words2 j)))
       (loop (add1 i) (add1 j) n m)]
      [else
       (let loop2 ([k (sub1 n)]
                  [l (sub1 m)]
                  [i i]
                  [j j])
         (cond
           [(and (>= k i) (>= l j) (string=? (list-ref words1 k) (list-ref words2 l)))
            (loop2 (sub1 k) (sub1 l) i j)]
           [else (and (<= k (sub1 i)) (<= l (sub1 j)))]))])))