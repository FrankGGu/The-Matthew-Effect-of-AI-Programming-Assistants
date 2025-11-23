(define (defuse-bomb key code)
  (map (lambda (x) (modulo (+ x key) 60)) code))