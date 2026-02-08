(define (even-odd-bits n)
  (let loop ([n n] [i 0] [even-count 0] [odd-count 0])
    (cond
      [(zero? n) (list even-count odd-count)]
      [else (let ([bit (modulo n 2)])
              (if (even? i)
                  (loop (quotient n 2) (+ i 1) (+ even-count bit) odd-count)
                  (loop (quotient n 2) (+ i 1) even-count (+ odd-count bit))))]))))