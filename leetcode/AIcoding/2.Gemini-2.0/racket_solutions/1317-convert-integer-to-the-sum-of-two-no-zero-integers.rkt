(define (no-zero? n)
  (not (string-contains? (number->string n) "0")))

(define (find-two-no-zero-integers n)
  (let loop ((a 1))
    (if (no-zero? a)
        (let ((b (- n a)))
          (if (and (no-zero? b) (<= 1 b n))
              (list a b)
              (loop (+ a 1))))
        (loop (+ a 1)))))

(define (integer->list n)
  (find-two-no-zero-integers n))