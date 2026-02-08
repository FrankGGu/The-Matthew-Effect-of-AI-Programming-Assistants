(define solution%
  (class object%
    (super-new)
    (init-field rects)
    (define total 0)
    (define weights (make-vector (length rects) 0)
    (define rect-list rects)

    (for ([i (in-range (length rects))]
          [rect (in-list rects)])
      (let* ([x1 (first rect)]
             [y1 (second rect)]
             [x2 (third rect)]
             [y2 (fourth rect)]
             [area (* (add1 (- x2 x1)) (add1 (- y2 y1)))])
        (set! total (+ total area))
        (vector-set! weights i total)))

    (define/public (pick)
      (let* ([rand (random total)]
             [idx (binary-search weights rand)])
        (let ([rect (list-ref rect-list idx)]
              [x1 (first rect)]
              [y1 (second rect)]
              [x2 (third rect)]
              [y2 (fourth rect)])
          (list (+ x1 (random (add1 (- x2 x1))))
                (+ y1 (random (add1 (- y2 y1)))))))

    (define (binary-search vec target)
      (let loop ([left 0]
                 [right (sub1 (vector-length vec))])
        (if (<= left right)
            (let* ([mid (quotient (+ left right) 2)]
                   [mid-val (vector-ref vec mid)])
              (cond
                [(< target mid-val) (loop left (sub1 mid))]
                [(> target mid-val) (loop (add1 mid) right)]
                [else mid]))
            left)))))