(define (number-of-collisions n k)
  (define (mod a b) (remainder a b))
  (define (gcd a b)
    (if (= b 0)
        a
        (gcd b (mod a b))))
  (define (lcm a b) (/ (* a b) (gcd a b)))
  (define (solve n k)
    (if (= k 0)
        0
        (let* ((g (gcd n k))
               (m (/ n g))
               (l (lcm m k)))
          (if (= l m)
              0
              (- l 1))))
  )
  (solve n k))