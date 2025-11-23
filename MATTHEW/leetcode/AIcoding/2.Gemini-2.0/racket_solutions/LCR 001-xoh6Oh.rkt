(define (divide dividend divisor)
  (define (abs x) (if (< x 0) (- x) x))
  (define (sign x y) (if (equal? (positive? x) (positive? y)) 1 -1))

  (define a (abs dividend))
  (define b (abs divisor))
  (define s (sign dividend divisor))

  (if (< a b)
      0
      (let loop ((q 0) (r a))
        (if (< r b)
            (* s q)
            (let* ((shift 0))
              (let loop2 ((tb b))
                (if (> tb r)
                    shift
                    (loop2 (* tb 2) (add1 shift))))
              (let* ((shifted-b (arithmetic-shift b shift))
                     (shifted-q (arithmetic-shift 1 shift)))
                (loop (+ q shifted-q) (- r shifted-b))))))))

  (let ((result (divide dividend divisor)))
    (cond
      [(> result 2147483647) 2147483647]
      [(< result -2147483648) -2147483648]
      [else result])))