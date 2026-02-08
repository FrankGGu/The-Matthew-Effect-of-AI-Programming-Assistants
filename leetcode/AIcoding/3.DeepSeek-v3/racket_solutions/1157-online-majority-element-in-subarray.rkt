(define majority-checker%
  (class object%
    (super-new)
    (init-field arr)

    (define n (length arr))
    (define idx (make-hash))

    (for ([i (in-range n)]
          [num (in-list arr)])
      (hash-update! idx num (lambda (v) (cons i v)) '()))

    (define/public (query left right threshold)
      (let loop ([k 20])
        (cond
          [(zero? k) -1]
          [else
           (define candidate (list-ref arr (random left (add1 right))))
           (define lst (hash-ref idx candidate))
           (define cnt (count (lambda (x) (and (>= x left) (<= x right))) lst))
           (if (>= cnt threshold)
               candidate
               (loop (sub1 k)))]))))