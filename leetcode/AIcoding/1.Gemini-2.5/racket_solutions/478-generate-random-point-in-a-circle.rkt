(require math)

(define-struct (solution) (radius x-center y-center))

(define (solution-pick s)
  (let* ((r (solution-radius s))
         (xc (solution-x-center s))
         (yc (solution-y-center s))
         (theta (* 2 pi (random)))
         (r-prime (* r (sqrt (random)))))
    (list (+ xc (* r-prime (cos theta)))
          (+ yc (* r-prime (sin theta))))))