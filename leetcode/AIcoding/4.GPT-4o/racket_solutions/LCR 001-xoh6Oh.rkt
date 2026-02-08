(define (divide a b)
  (if (or (= b 0) (and (= a -2147483648) (= b -1)))
      2147483647
      (let loop ((x (if (and (< a 0) (< b 0)) (abs a) (if (< a 0) (- (abs a)) (if (< b 0) (- (abs b)) (abs a)))))
                   (y (if (and (< a 0) (< b 0)) (abs b) (if (< a 0) (- (abs b)) (if (< b 0) (- (abs a)) (abs b)))))
                   (count 0))
        (if (< x y)
            count
            (loop (- x y) y (+ count 1))))))

(define (divide a b)
  (if (or (= b 0) (and (= a -2147483648) (= b -1)))
      2147483647
      (let loop ((x (if (and (< a 0) (< b 0)) (abs a) (if (< a 0) (- (abs a)) (if (< b 0) (- (abs b)) (abs a)))))
                   (y (if (and (< a 0) (< b 0)) (abs b) (if (< a 0) (- (abs b)) (if (< b 0) (- (abs a)) (abs b)))))
                   (count 0))
        (if (< x y)
            (if (and (< a 0) (< b 0)) (- count) (if (< a 0) (- count) (if (< b 0) (- count) count)))
            (loop (- x y) y (+ count 1))))))