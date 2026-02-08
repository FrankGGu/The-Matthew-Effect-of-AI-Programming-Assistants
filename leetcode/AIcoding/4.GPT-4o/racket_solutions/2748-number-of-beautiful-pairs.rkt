(define (count-beautiful-pairs nums)
  (define (gcd a b)
    (if (= b 0)
        a
        (gcd b (modulo a b))))
  (define (count-pairs n)
    (if (< n 2)
        0
        (for/sum ([i (in-range n)]
                   [j (in-range (+ i 1) n)])
          (if (= 1 (gcd (vector-ref nums i) (vector-ref nums j)))
              1
              0))))
  (count-pairs (vector-length nums)))

(define (number-of-beautiful-pairs nums)
  (count-beautiful-pairs (vector->list nums)))