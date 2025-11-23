(define MOD 1000000007)

(define (number-of-ways startPos endPos k)
  (let ((distance (abs (- endPos startPos))))
    (if (or (> distance k) (not (zero? (modulo (- k distance) 2))))
        0
        (let ((steps-right (quotient (+ k distance) 2)))
          (combinations k steps-right)))))

(define (combinations n k)
  (if (or (< k 0) (> k n))
      0
      (let ((k (min k (- n k))))
        (let loop ((i 1) (res 1))
          (if (> i k)
              res
              (loop (+ i 1) (modulo (* res (quotient (+ (- n k) i) i)) MOD)))))))