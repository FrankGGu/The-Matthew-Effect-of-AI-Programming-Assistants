(define (count-substrings-starting-and-ending-with-given-character s c)
  (let ([k (for/sum ([ch (in-string s)])
             (if (char=? ch c) 1 0))])
    (/ (* k (+ k 1)) 2)))