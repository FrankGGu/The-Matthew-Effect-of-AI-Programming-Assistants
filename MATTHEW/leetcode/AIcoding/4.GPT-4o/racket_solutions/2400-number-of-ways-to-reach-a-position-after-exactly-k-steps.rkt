(define (numberOfWays startPos endPos k)
  (define (factorial n)
    (if (= n 0) 1 (* n (factorial (- n 1)))))

  (define (nCr n r)
    (if (> r n) 0
        (/ (factorial n) (* (factorial r) (factorial (- n r))))))

  (define (ways n k)
    (if (< k 0) 0
        (nCr (+ n k) (* 2 k))))

  (let ((distance (abs (- startPos endPos))))
    (if (and (>= k distance) (even? (- k distance)))
        (ways (- k distance) (/ (+ k distance) 2))
        0)))