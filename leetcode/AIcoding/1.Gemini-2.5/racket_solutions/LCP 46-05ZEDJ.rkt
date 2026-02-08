(define MOD 1000000007)

(define (power base exp)
  (let loop ((b base) (e exp) (res 1))
    (cond
      ((zero? e) res)
      ((odd? e) (loop (modulo (* b b) MOD) (quotient e 2) (modulo (* res b) MOD)))
      (else (loop (modulo (* b b) MOD) (quotient e 2) res)))))

(define (inv n)
  (power n (- MOD 2)))

(define factorials
  (let* ((max-val 2005) ; Max value for n + m - 1 is 1000 + 1000 - 1 = 1999. Add some buffer.
         (fact-vec (make-vector max-val 1)))
    (for ((i (in-range 2 max-val)))
      (vector-set! fact-vec i (modulo (* (vector-ref fact-vec (- i 1)) i) MOD)))
    fact-vec))

(define (combinations n k)
  (cond
    ((or (< k 0) (> k n)) 0)
    ((or (= k 0) (= k n)) 1)
    (else
     (let* ((n-fact (vector-ref factorials n))
            (k-fact (vector-ref factorials k))
            (nk-fact (vector-ref factorials (- n k))))
       (modulo
        (* n-fact
           (inv k-fact)
           (inv nk-fact))
        MOD)))))

(define (distributeVolunteers n m k)
  (let ((n-prime (- n (* m k))))
    (if (< n-prime 0)
        0
        (combinations (+ n-prime m -1) (- m 1)))))