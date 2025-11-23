(define (countBalancedPermutations n)
  (define (factorial x)
    (if (= x 0) 1 (* x (factorial (- x 1)))))
  (define (g n)
    (if (= n 0) 1
        (let ((fact (factorial n)))
          (/ (* fact fact) (factorial (* 2 n))))))
  (g n))

(define (numBalancedPermutations n)
  (countBalancedPermutations n))