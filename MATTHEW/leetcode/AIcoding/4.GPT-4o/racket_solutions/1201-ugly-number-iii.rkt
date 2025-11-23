(define (nthUglyNumber n a b c)
  (define (lcm x y)
    (/ (* x y) (gcd x y)))

  (define lcm-ab (lcm a b))
  (define lcm-ac (lcm a c))
  (define lcm-bc (lcm b c))
  (define lcm-abc (lcm lcm-ab c))

  (define (countUglyNumbers x)
    (+ (quotient x a) (quotient x b) (quotient x c)
       (- (quotient x lcm-ab) (quotient x lcm-ac) (quotient x lcm-bc))
       (+ (quotient x lcm-abc)))

  (define (binarySearch left right)
    (if (= left right)
        left
        (let ((mid (quotient (+ left right) 2)))
          (if (>= (countUglyNumbers mid) n)
              (binarySearch left mid)
              (binarySearch (+ mid 1) right)))))

  (binarySearch 1 (* n (min a (min b c)))))