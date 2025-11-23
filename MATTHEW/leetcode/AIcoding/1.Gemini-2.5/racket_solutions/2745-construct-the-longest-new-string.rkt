(define (longest-new-string x y z)
  (+ (* 2 z)
     (* 2 (+ (* 2 (min x y))
             (if (= x y) 0 1)))))