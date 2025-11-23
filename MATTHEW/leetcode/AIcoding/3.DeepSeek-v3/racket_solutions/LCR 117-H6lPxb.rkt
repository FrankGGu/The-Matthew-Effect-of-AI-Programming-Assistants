(define (num-similar-groups strs)
  (define n (length strs))
  (define parent (make-vector n 0))
  (for ([i (in-range n)]) (vector-set! parent i i))

  (define (find u)
    (if (= u (vector-ref parent u))
        u
        (begin
          (vector-set! parent u (find (vector-ref parent u)))
          (vector-ref parent u))))

  (define (union u v)
    (let ([pu (find u)]
          [pv (find v)])
      (when (not (= pu pv))
        (vector-set! parent pv pu))))

  (for ([i (in-range n)]
        [s1 (in-list strs)])
    (for ([j (in-range (add1 i) n)]
          [s2 (in-list (drop strs (add1 i)))])
      (when (similar? s1 s2)
        (union i j))))

  (define roots (mutable-set))
  (for ([i (in-range n)])
    (set-add! roots (find i)))
  (set-count roots))

(define (similar? s1 s2)
  (define diff 0)
  (for ([c1 (in-string s1)]
        [c2 (in-string s2)]
        #:break (> diff 2))
    (when (not (char=? c1 c2))
      (set! diff (add1 diff))))
  (or (= diff 0) (= diff 2)))