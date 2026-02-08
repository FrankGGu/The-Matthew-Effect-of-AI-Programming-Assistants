(define (visible-points points angle location)
  (define (angle-diff a b)
    (modulo (- b a) 360))

  (define angles
    (map (lambda (p)
           (angle-diff (atan (/ (- (second p) (second location)) 
                                 (- (first p) (first location)))) 
                            0))
         points))

  (define sorted-angles (sort angles <))
  (define extended-angles (append sorted-angles 
                                   (map (lambda (x) (+ x 360)) sorted-angles)))

  (define count (length points))
  (define max-visible 0)
  (define j 0)

  (for ([i (in-range count)])
    (while (and (< j (* 360 2))
                (<= (list-ref extended-angles j) (+ (list-ref sorted-angles i) angle)))
      (set! j (+ j 1)))
    (set! max-visible (max max-visible (- j i))))

  max-visible)

(visible-points '((2,1) (2,2) (3,3)) 90 '(1,1))