(define (num-slices s i j)
  (if (>= i (- j 1))
      0
      (+ (- j i 1) (num-slices s (+ i 1) j))))

(define (slices s i j)
  (if (>= (- j i) 2)
      (if (= (- (string-ref s j) (string-ref s (- j 1)))
             (- (string-ref s (- j 1)) (string-ref s (- j 2))))
          (+ (num-slices s i j) (slices s (+ i 1) j))
          (slices s (+ i 1) j))
      0))

(define (number-of-arithmetic-slices s)
  (if (< (string-length s) 2)
      0
      (slices s 0 (- (string-length s) 1))))