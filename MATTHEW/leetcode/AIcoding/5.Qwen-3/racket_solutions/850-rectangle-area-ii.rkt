(define (rectangle-area rectangles)
  (define (overlap a b)
    (let ((x1 (car a)) (y1 (cadr a)) (x2 (caddr a)) (y2 (cadddr a))
          (x3 (car b)) (y3 (cadr b)) (x4 (caddr b)) (y4 (cadddr b)))
      (if (and (<= x3 x2) (<= x1 x4) (<= y3 y2) (<= y1 y4))
          (let ((ox1 (max x1 x3)) (oy1 (max y1 y3))
                (ox2 (min x2 x4)) (oy2 (min y2 y4)))
            (* (- ox2 ox1) (- oy2 oy1)))
          0)))

  (define (combine rects)
    (if (null? rects)
        0
        (+ (apply - (map (lambda (r) (apply * (cdr r))) rects))
           (for/sum ((i (in-range (length rects))))
             (for/sum ((j (in-range (add1 i) (length rects))))
               (overlap (list-ref rects i) (list-ref rects j)))))))

  (combine rectangles))