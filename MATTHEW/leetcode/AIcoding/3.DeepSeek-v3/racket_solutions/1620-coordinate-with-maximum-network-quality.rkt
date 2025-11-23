(define/contract (best-coordinate towers radius)
  (-> (listof (listof exact-integer?)) exact-integer? (listof exact-integer?))
  (define (distance x1 y1 x2 y2)
    (sqrt (+ (expt (- x1 x2) 2) (expt (- y1 y2) 2))))

  (define (signal x y)
    (for/sum ([tower towers])
      (define tx (first tower))
      (define ty (second tower))
      (define d (distance x y tx ty))
      (if (<= d radius)
          (floor (/ (third tower) (+ 1 d)))
          0)))

  (define max-x (apply max (map first towers)))
  (define max-y (apply max (map second towers)))

  (define max-signal -inf.0)
  (define result '())

  (for* ([x (in-range (add1 max-x))]
         [y (in-range (add1 max-y))])
    (define current (signal x y))
    (cond
      [(> current max-signal)
       (set! max-signal current)
       (set! result (list x y))]
      [(and (= current max-signal)
            (or (< x (first result))
                (and (= x (first result)) (< y (second result)))))
       (set! result (list x y))]))

  (if (null? result) '(0 0) result))