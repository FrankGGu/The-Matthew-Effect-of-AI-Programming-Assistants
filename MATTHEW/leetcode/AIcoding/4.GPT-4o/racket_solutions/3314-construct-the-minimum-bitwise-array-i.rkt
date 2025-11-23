(define (construct-minimum-bitwise-array arr)
  (map (lambda (x) (if (zero? x) 0 (logbitwise-or (apply logbitwise-or (map logbitwise-xor arr)) x))) arr))

(define (get-minimum-bitwise-array arr)
  (let ([n (length arr)])
    (construct-minimum-bitwise-array arr)))

(get-minimum-bitwise-array '(1 2 3 4))