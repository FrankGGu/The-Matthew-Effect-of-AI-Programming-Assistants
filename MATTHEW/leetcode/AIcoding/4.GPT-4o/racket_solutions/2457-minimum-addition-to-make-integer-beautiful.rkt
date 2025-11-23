(define (minimal-beautiful n)
  (define (digit-sum x)
    (if (= x 0) 0
        (+ (modulo x 10) (digit-sum (quotient x 10)))))
  (define (helper x)
    (if (< (digit-sum x) 10) 0
        (let* ((next-multiple-of-10 (+ x (modulo 10 (- 10 (modulo (digit-sum x) 10)))))
               (needed (+ next-multiple-of-10 (digit-sum next-multiple-of-10))))
          (- needed x))))
  (helper n))

(define (minimum-addition n)
  (minimal-beautiful n))