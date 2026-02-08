(define MOD 1000000007)

(define (make-factorials n)
  (let ((fact (make-vector (+ n 1))))
    (vector-set! fact 0 1)
    (for ((i (in-range 1 (+ n 1))))
      (vector-set! fact i (modulo (* (vector-ref fact (- i 1)) i) MOD)))
    fact))

(define MAX_K 100000)
(define factorials (make-factorials MAX_K))

(define (power base exp)
  (let loop ((b base) (e exp) (res 1))
    (cond
      ((zero? e) res)
      ((odd? e) (loop (modulo (* b b) MOD) (quotient e 2) (modulo (* res b) MOD)))
      (else (loop (modulo (* b b) MOD) (quotient e 2) res)))))

(define (mod-inverse n)
  (power n (- MOD 2)))

(define (nCk n k)
  (cond
    ((or (< k 0) (> k n)) 0)
    ((or (= k 0) (= k n)) 1)
    (else
     (let* ((num (vector-ref factorials n))
            (den1 (vector-ref factorials k))
            (den2 (vector-ref factorials (- n k)))
            (inv-den1 (mod-inverse den1))
            (inv-den2 (mod-inverse den2)))
       (modulo (* num inv-den1 inv-den2) MOD)))))

(define (number-of-ways startPos endPos k)
  (let* ((diff (- endPos startPos)))
    (cond
      ((or (< k (abs diff))
           (odd? (+ k diff)))
       0)
      (else
       (let ((p (quotient (+ k diff) 2)))
         (nCk k p))))))