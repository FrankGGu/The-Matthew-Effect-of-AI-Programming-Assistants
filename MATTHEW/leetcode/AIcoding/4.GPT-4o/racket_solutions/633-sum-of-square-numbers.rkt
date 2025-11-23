(define (judgeSquareSum c)
  (define (is-square n)
    (define root (sqrt n))
    (and (= root (floor root)) (> n -1)))

  (define (two-squares? a)
    (let loop ((b 0))
      (cond [(> b (sqrt c)) #f]
            [(is-square (- c (* a a))) #t]
            [else (loop (+ b 1))])))

  (define (find-squares a)
    (if (> a (sqrt c)) #f
        (or (two-squares? a) (find-squares (+ a 1)))))

  (find-squares 0))