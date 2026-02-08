(define (hamming-distance x y)
  (let loop ([n (bitwise-xor x y)] [count 0])
    (if (zero? n)
        count
        (loop (bitwise-and n (sub1 n)) (add1 count)))))