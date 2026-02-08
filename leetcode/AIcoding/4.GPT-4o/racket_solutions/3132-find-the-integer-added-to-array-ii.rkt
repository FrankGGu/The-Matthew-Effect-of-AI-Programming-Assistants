(define (find-the-integer-added-to-array arr)
  (define (binary-search lo hi)
    (if (> lo hi)
        lo
        (let ((mid (quotient (+ lo hi) 2)))
          (if (>= (sum-less-equal arr mid) mid)
              (binary-search lo (sub1 mid))
              (binary-search (add1 mid) hi)))))

  (define (sum-less-equal arr x)
    (foldl (lambda (n acc) (if (<= n x) (+ acc n) acc)) 0 arr))

  (binary-search 0 (length arr)))