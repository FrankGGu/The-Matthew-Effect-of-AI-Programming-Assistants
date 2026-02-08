(define (minFlips a b c)
  (define (count-flips a b c)
    (cond
      [(= c 0) (+ (if (zero? a) 1 0) (if (zero? b) 1 0))]
      [(= (bitwise-and a b) c) 0]
      [else
       (let* ([not-a (bitwise-not a)]
              [not-b (bitwise-not b)]
              [flip-a (if (zero? (bitwise-and c a)) 1 0)]
              [flip-b (if (zero? (bitwise-and c b)) 1 0)]
              [flip-c (if (zero? (bitwise-and c (bitwise-or a b))) 1 0)])
         (+ flip-a flip-b flip-c))]))
  (count-flips a b c))

(minFlips 2 6 5)