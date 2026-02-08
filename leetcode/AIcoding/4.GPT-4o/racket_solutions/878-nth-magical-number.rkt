(define (nthMagicalNumber n a b)
  (define mod (expt 10 9))
  (define lcm (lambda (x y) (/ (* x y) (gcd x y))))
  (define lcm-ab (lcm a b))
  (define total (quotient lcm-ab a))
  (define total-b (quotient lcm-ab b))
  (define total-ab (* total total-b))

  (define left 0)
  (define right (* n (min a b)))

  (define (count x)
    (+ (quotient x a) (quotient x b) (- (quotient x lcm-ab)))
  )

  (define result 0)

  (while (< left right)
    (define mid (quotient (+ left right) 2))
    (if (>= (count mid) n)
        (set! right mid)
        (set! left (+ mid 1))))

  (mod left))