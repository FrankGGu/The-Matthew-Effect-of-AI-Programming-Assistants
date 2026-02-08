(define (minimum-abs-difference-queries nums queries)
  (define n (length nums))
  (define sorted-nums (sort nums <))
  (define ans (make-vector (length queries) -1))

  (for/list ([i (in-range (length queries))])
    (let* ([query (list-ref queries i)]
           [l (list-ref query 0)]
           [r (list-ref query 1)]
           [sub-array (take (drop sorted-nums l) (+ 1 (- r l)))]
           [len (length sub-array)])
      (if (< len 2)
          -1
          (let loop ([idx 1]
                     [min-diff +inf.0])
            (if (= idx len)
                min-diff
                (let ([diff (- (list-ref sub-array idx) (list-ref sub-array (- idx 1)))])
                  (loop (+ idx 1) (min min-diff diff)))))))))