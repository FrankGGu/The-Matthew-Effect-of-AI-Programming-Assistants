(define (decode encoded)
  (let* ([n (add1 (length encoded))]
         [total-xor (foldl bitwise-xor 0 (range 1 (add1 n)))]
         [first (foldl bitwise-xor total-xor (for/list ([i (in-range 1 n 2)])
                       (foldl bitwise-xor 0 (list-tail encoded (sub1 i))))])
    (let loop ([res (list first)]
               [prev first]
               [rest encoded])
      (if (null? rest)
          (reverse res)
          (let ([next (bitwise-xor prev (car rest))])
            (loop (cons next res) next (cdr rest))))))