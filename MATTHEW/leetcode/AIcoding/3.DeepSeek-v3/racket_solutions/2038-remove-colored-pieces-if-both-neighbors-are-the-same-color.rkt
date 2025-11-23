(define (winner-of-game colors)
  (let loop ([i 1] [a 0] [b 0] [n (string-length colors)])
    (cond
      [(>= i (- n 1)) (if (> a b) #t #f)]
      [else
       (let ([c (string-ref colors i)]
             [prev (string-ref colors (- i 1))]
             [next (string-ref colors (+ i 1))])
         (cond
           [(and (char=? c #\A) (char=? prev #\A) (char=? next #\A))
            (loop (+ i 1) (+ a 1) b n)]
           [(and (char=? c #\B) (char=? prev #\B) (char=? next #\B))
            (loop (+ i 1) a (+ b 1) n)]
           [else (loop (+ i 1) a b n)]))])))