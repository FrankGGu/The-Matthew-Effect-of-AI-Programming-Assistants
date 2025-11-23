(define (number-of-ways points)
  (define (can-place? p1 p2)
    (and (<= (first p1) (first p2))
         (<= (second p1) (second p2))))

  (define (solve placed remaining)
    (cond
      [(empty? remaining) 1]
      [else
       (let loop ([candidates remaining] [acc 0])
         (cond
           [(empty? candidates) acc]
           [else
            (let ([candidate (first candidates)])
              (if (andmap (λ (p) (can-place? p candidate)) placed)
                  (loop (rest candidates) (+ acc (solve (append placed (list candidate)) (remove candidate remaining))))
                  (loop (rest candidates) acc))))])]))

  (solve '() points))