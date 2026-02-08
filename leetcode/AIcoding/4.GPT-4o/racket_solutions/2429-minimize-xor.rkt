(define (minimize-xor num1 num2)
  (define (count-bits n)
    (if (= n 0) 0
        (+ (count-bits (ash n -1)) (if (odd? n) 1 0))))
  (define bits (count-bits num2))
  (define (find-min-xor n b)
    (if (= b 0) n
        (if (zero? (bitwise-and n n))
            (find-min-xor (ash n 1) (sub1 b))
            (find-min-xor (add1 n) (sub1 b)))))
  (find-min-xor num1 bits))

(minimize-xor 3 5)