(define (check-if-it-is-a-straight-line coordinates)
  (let* ([x0 (caar coordinates)]
         [y0 (cadar coordinates)]
         [dx (- (caadr coordinates) x0)]
         [dy (- (cadadr coordinates) y0)])
    (andmap (lambda (p)
              (let ([x (car p)]
                    [y (cadr p)])
                (= (* dx (- y y0)) (* dy (- x x0)))))
            (cdr coordinates))))