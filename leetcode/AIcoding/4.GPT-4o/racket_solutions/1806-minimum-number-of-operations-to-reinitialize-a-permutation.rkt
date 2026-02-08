(define (reinitializePermutation n)
  (define (helper p ops)
    (if (equal? p (build-list n (lambda (i) i)))
        ops
        (helper (map (lambda (i) (if (even? i) (/ i 2) (+ (/ (- i 1) 2) (/ n 2)))) p) ops)))
  (helper (build-list n (lambda (i) i)) 0))

(reinitializePermutation 6)