(define (count-hidden-sequences n m k)
  (define (factorial x)
    (if (= x 0) 1 (* x (factorial (- x 1)))))
  (define (comb n r)
    (if (< r 0) 0
        (if (= r 0) 1
            (/ (factorial n) (* (factorial r) (factorial (- n r)))))))
  (if (and (<= k n) (<= k m))
      (comb n k)
      0))

(define (countHiddenSequences n m k)
  (count-hidden-sequences n m k))