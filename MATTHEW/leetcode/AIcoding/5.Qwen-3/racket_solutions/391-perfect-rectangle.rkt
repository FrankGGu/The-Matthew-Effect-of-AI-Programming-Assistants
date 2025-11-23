#lang racket

(define (perfect-rectangle rectangles)
  (define (area p1 p2)
    (* (- (car p2) (car p1)) (- (cadr p2) (cadr p1))))

  (define (combine a b)
    (let ([x1 (min (car a) (car b))]
          [y1 (min (cadr a) (cadr b))]
          [x2 (max (caddr a) (caddr b))]
          [y2 (max (cadddr a) (cadddr b))])
      (list x1 y1 x2 y2)))

  (define (is-overlap a b)
    (and (< (car a) (caddr b))
         (> (caddr a) (car b))
         (< (cadr a) (cadddr b))
         (> (cadddr a) (cadr b))))

  (define (remove-overlaps rects)
    (let loop ([rects rects] [result '()])
      (if (null? rects)
          result
          (let ([current (car rects)])
            (let ([overlaps (filter (lambda (r) (is-overlap current r)) (cdr rects))])
              (if (null? overlaps)
                  (loop (cdr rects) (cons current result))
                  (let ([new-rects (append (filter (lambda (r) (not (is-overlap current r))) (cdr rects))
                                          (map (lambda (r) (combine current r)) overlaps))])
                    (loop new-rects result))))))))

  (let ([all-areas (apply + (map (lambda (r) (area (list (car r) (cadr r)) (list (caddr r) (cadddr r)))) rectangles))])
    (let ([unique-points (foldl (lambda (r acc)
                                  (set-add acc (list (car r) (cadr r)))
                                  (set-add acc (list (caddr r) (cadddr r)))
                                  (set-add acc (list (car r) (cadddr r)))
                                  (set-add acc (list (caddr r) (cadr r))))
                                (set) rectangles)])
      (and (= (set-count unique-points) 4)
           (= all-areas (area (list (apply min (map car rectangles)) (apply min (map cadr rectangles)))
                              (list (apply max (map caddr rectangles)) (apply max (map cadddr rectangles)))))))))