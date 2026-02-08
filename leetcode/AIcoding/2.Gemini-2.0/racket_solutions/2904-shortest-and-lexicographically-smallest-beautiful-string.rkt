(define (shortest-beautiful-substring s k)
  (define n (string-length s))
  (define min-len (add1 n))
  (define ans "")

  (for ([i (in-range n)])
    (define count 0)
    (for ([j (in-range i n)])
      (when (string=? (substring s j (add1 j)) "1")
        (set! count (add1 count)))
      (when (>= count k)
        (define len (add1 (- j i)))
        (define sub (substring s i (add1 j)))
        (cond
          [(< len min-len)
           (set! min-len len)
           (set! ans sub)]
          [(= len min-len)
           (when (string<? sub ans)
             (set! ans sub))]))))

  (if (= min-len (add1 n))
      ""
      ans))