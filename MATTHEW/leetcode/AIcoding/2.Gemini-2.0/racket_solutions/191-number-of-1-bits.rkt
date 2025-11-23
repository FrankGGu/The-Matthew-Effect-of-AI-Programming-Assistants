(define (hammingWeight n)
  (let loop ([n n] [count 0])
    (if (= n 0)
        count
        (loop (bitwise-and n (- n 1)) (+ count 1)))))