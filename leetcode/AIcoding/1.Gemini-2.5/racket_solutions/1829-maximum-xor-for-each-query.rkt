(define (get-maximum-xor nums maximumBit)
  (let* ([max-target (sub1 (expt 2 maximumBit))]
         [current-xor 0]
         [result '()])
    (for-each
     (lambda (num)
       (set! current-xor (bitwise-xor current-xor num))
       (set! result (cons (bitwise-xor current-xor max-target) result)))
     nums)
    (reverse result)))