(define (triangleType a b c)
  (cond
    [(or (<= a 0) (<= b 0) (<= c 0)) 0]
    [(= a b c) 1]
    [(or (= a b) (= b c) (= a c)) 2]
    [else 3]))

(triangleType 3 4 5) ; Output: 3