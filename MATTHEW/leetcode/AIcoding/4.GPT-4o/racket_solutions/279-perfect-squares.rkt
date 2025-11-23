(define (numSquares n)
  (define (is-perfect-square x)
    (let loop ((i 1))
      (cond [(> (* i i) x) #f]
            [(= (* i i) x) #t]
            [else (loop (+ i 1))])))

  (define (dp k)
    (if (zero? k) 0
        (let loop ((i 1) (min-squares +))
          (if (> (* i i) k)
              min-squares
              (let ((squares (dp (- k (* i i)))))
                (loop (+ i 1) (min min-squares (+ squares 1))))))))

  (dp n))

(numSquares)