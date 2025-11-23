(define (isReachable x y)
  (let loop ((x x) (y y))
    (if (or (zero? x) (zero? y))
        (and (zero? x) (zero? y))
        (if (< x y)
            (loop x (- y x))
            (loop (- x y) y)))))

(isReachable 1 2)  ; Example usage