(define (minimize-the-maximum val div1 div2 c1 c2)
  (let loop ((l 1) (r val))
    (if (> l r)
        r
        (let ((mid (quotient (+ l r) 2)))
          (let ((a (- mid (quotient mid div1)))
                (b (- mid (quotient mid div2)))
                (both (- mid (quotient mid (* div1 div2) (lcm div1 div2)))))
            (if (and (>= a c1) (>= b c2) (>= (+ a b both) (+ c1 c2)))
                (loop l (- mid 1))
                (loop (+ mid 1) r)))))))

(define (minimize-maximum-of-two-arrays n div1 div2 c1 c2)
  (minimize-the-maximum n div1 div2 c1 c2))