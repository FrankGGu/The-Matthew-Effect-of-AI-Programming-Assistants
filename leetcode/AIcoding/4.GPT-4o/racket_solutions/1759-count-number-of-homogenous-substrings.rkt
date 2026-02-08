(define (count-homogenous substr)
  (define len (string-length substr))
  (define total 0)
  (define current 1)

  (for ((i (in-range 1 len)))
    (when (equal? (string-ref substr (- i 1)) (string-ref substr i))
      (set! current (+ current 1))
      (set! total (+ total current)))
    (when (not (equal? (string-ref substr (- i 1)) (string-ref substr i)))
      (set! current 1)
      (set! total (+ total current))))

  total)

(define (countHomogenous s)
  (count-homogenous s))