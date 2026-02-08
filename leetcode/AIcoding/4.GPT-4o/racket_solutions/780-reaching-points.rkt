(define (can-reach tx ty sx sy)
  (let loop ((x sx) (y sy))
    (cond
      ((> x tx) #f)
      ((> y ty) #f)
      ((= x tx) (= y ty))
      ((= y ty) (= x tx))
      (else (loop (if (> x y) (- x y) x) (if (> y x) (- y x) y)))))))

(define (reaching-points sx sy tx ty)
  (can-reach tx ty sx sy))