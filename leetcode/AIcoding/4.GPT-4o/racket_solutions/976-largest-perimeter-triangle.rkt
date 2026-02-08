(define (largestPerimeter A)
  (define sorted (sort A >))
  (define (check-triangle a b c)
    (if (and (< 0 (+ a b c)) (> a 0) (> b 0) (> c 0))
        (if (>= (+ a b) c)
            (+ a b c)
            0)
        0))
  (for/or ([i (in-range (sub1 (length sorted)))])
    (let ([a (list-ref sorted i)]
          [b (list-ref sorted (add1 i))]
          [c (list-ref sorted (add2 i))])
      (check-triangle a b c))))