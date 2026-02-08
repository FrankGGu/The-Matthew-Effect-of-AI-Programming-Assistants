(define/contract (min-manhattan-distance points)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (define (manhattan-dist p1 p2)
    (+ (abs (- (first p1) (first p2))) (abs (- (second p1) (second p2)))))

  (define (max-manhattan-points ps)
    (let loop ([ps ps] [min-x +inf.0] [max-x -inf.0] [min-y +inf.0] [max-y -inf.0]
               [min-sum +inf.0] [max-sum -inf.0] [min-diff +inf.0] [max-diff -inf.0])
      (if (null? ps)
          (max (- max-x min-x) (- max-y min-y) (- max-sum min-sum) (- max-diff min-diff))
          (let* ([p (car ps)]
                 [x (first p)]
                 [y (second p)]
                 [sum (+ x y)]
                 [diff (- x y)])
            (loop (cdr ps)
                  (min min-x x) (max max-x x)
                  (min min-y y) (max max-y y)
                  (min min-sum sum) (max max-sum sum)
                  (min min-diff diff) (max max-diff diff))))))

  (if (< (length points) 2)
      0
      (max-manhattan-points points)))