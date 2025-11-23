(define (twoEggDrop n)
  (define (helper x y)
    (if (= y 0)
        0
        (if (= x 1)
            y
            (let loop ((k 1) (res +inf.0))
              (if (> k y)
                  res
                  (let ((temp (max (helper (- x 1) (- k 1)) (helper x (- y k)))))
                    (loop (+ k 1) (min res (+ temp 1)))))))))
  (helper 2 n))

(twoEggDrop n)