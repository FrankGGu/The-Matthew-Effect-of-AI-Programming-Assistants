(define/contract (find-min-arrow-shots points)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (if (null? points)
      0
      (let ([sorted-points (sort points (lambda (a b) (< (second a) (second b))))])
        (let loop ([arrows 1] [current-end (second (car sorted-points))] [rest-points (cdr sorted-points)])
          (if (null? rest-points)
              arrows
              (let ([point (car rest-points)])
                (if (> (car point) current-end)
                    (loop (add1 arrows) (second point) (cdr rest-points))
                    (loop arrows current-end (cdr rest-points))))))))