(define (minOperations n)
  (let ((target (add1 (/ n 2))))
    (* target target)))