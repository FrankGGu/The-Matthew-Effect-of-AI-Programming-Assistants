(define (get-maximum-xor nums maximumBit)
  (let* ([n (length nums)]
         [max-possible (sub1 (arithmetic-shift 1 maximumBit))]
         [prefix-xor (make-vector n 0)])
    (vector-set! prefix-xor 0 (list-ref nums 0))
    (for ([i (in-range 1 n)])
      (vector-set! prefix-xor i (bitwise-xor (vector-ref prefix-xor (sub1 i)) (list-ref nums i)))
    (for/list ([i (in-range n)])
      (bitwise-xor (vector-ref prefix-xor (- n 1 i)) max-possible))))