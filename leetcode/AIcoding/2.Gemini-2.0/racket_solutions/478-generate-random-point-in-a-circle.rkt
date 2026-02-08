(struct Solution (radius x_center y_center) #:mutable)

(define (Solution radius x_center y_center)
  (struct-copy Solution (Solution radius x_center y_center) #:mutable))

(define (Solution-new radius x_center y_center)
  (Solution radius x_center y_center))

(define (rand-point s)
  (let loop ()
    (let* ([x (* (random) 2) - 1]
           [y (* (random) 2) - 1])
      (if (<= (+ (* x x) (* y y)) 1)
          (list (+ (* x (Solution-radius s)) (Solution-x_center s))
                (+ (* y (Solution-radius s)) (Solution-y_center s)))
          (loop)))))