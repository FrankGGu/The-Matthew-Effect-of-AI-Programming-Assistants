(define (check-if-all-the-integers-in-a-range-are-covered ranges left right)
  (for/and ([num (in-range left (add1 right))])
    (define (is-covered? n)
      (for/or ([r ranges])
        (let ([start (first r)]
              [end (second r)])
          (and (<= start n) (<= n end)))))
    (is-covered? num)))