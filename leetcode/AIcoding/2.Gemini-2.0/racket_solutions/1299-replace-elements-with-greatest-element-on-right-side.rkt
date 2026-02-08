(define (replace-elements arr)
  (let loop ([i (- (length arr) 2)]
             [max-right (last arr)]
             [result (vector max-right)])
    (if (< i 0)
        (vector-append (vector -1) result)
        (let ([current (vector-ref arr i)])
          (vector-set! arr i max-right)
          (loop (- i 1) (max max-right current) (vector-append result (vector max-right)))))))