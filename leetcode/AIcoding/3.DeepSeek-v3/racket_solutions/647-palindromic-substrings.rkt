(define/contract (count-substrings s)
  (-> string? exact-integer?)
  (define n (string-length s))
  (define count 0)

  (define (expand l r)
    (let loop ([l l] [r r])
      (when (and (>= l 0) (< r n) (char=? (string-ref s l) (string-ref s r)))
        (set! count (add1 count))
        (loop (sub1 l) (add1 r)))))

  (for ([i (in-range n)])
    (expand i i)
    (expand i (add1 i)))

  count)