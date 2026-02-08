(define MOD 1000000007)

(define (power base exp)
  (let loop ((b base) (e exp) (res 1))
    (cond
      ((zero? e) res)
      ((odd? e) (loop (modulo (* b b) MOD) (quotient e 2) (modulo (* res b) MOD)))
      (else (loop (modulo (* b b) MOD) (quotient e 2) res)))))

(define (mod-inverse n)
  (power n (- MOD 2)))

(define (solution n colors heights)
  (let* ((color-counts (make-hash))
         (fact (make-vector (+ n 1))))

    (for-each (lambda (color)
                (hash-update! color-counts color (lambda (val) (add1 (or val 0))) 0))
              colors)

    (vector-set! fact 0 1)
    (for ((i (in-range 1 (+ n 1))))
      (vector-set! fact i (modulo (* i (vector-ref fact (- i 1))) MOD)))

    (let loop ((res (vector-ref fact n))
               (keys (hash-keys color-counts)))
      (if (empty? keys)
          res
          (let* ((color (car keys))
                 (count (hash-ref color-counts color))
                 (denom-fact (vector-ref fact count))
                 (inv-denom-fact (mod-inverse denom-fact)))
            (loop (modulo (* res inv-denom-fact) MOD)
                  (cdr keys)))))))