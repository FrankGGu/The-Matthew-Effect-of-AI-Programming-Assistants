(define (find-closest-divisors-for-target target)
  (let loop ((i (floor (sqrt target))))
    (cond
      ((<= i 0) (error "Target must have at least one divisor (1). This case should not be reached for positive targets."))
      ((zero? (remainder target i)) (list i (quotient target i)))
      (else (loop (- i 1))))))

(define (closest-divisors num)
  (let* ((n1 (+ num 1))
         (n2 (+ num 2))
         (pair1 (find-closest-divisors-for-target n1))
         (pair2 (find-closest-divisors-for-target n2))
         (a1 (car pair1))
         (b1 (cadr pair1))
         (a2 (car pair2))
         (b2 (cadr pair2)))
    (if (<= (abs (- a1 b1)) (abs (- a2 b2)))
        pair1
        pair2)))