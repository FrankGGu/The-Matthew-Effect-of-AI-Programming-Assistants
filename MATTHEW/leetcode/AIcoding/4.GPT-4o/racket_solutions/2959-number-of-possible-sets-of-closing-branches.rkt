(define (count-possible-sets n)
  (define (factorial x)
    (if (= x 0)
        1
        (* x (factorial (- x 1)))))
  (define (nCk n k)
    (/ (factorial n) (* (factorial k) (factorial (- n k)))))
  (define (total-sets n)
    (foldl (lambda (k acc) (+ acc (nCk n k))) 0 (range 0 (+ n 1))))
  (total-sets n))

(define (numberOfPossibleSets n)
  (count-possible-sets n))

(numberOfPossibleSets n)