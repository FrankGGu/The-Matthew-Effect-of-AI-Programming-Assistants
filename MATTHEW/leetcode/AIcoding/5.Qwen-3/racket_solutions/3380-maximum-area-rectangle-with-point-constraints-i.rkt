#lang racket

(define (max-area rectangles)
  (define (area x1 y1 x2 y2)
    (* (- x2 x1) (- y2 y1)))

  (define (valid? x1 y1 x2 y2)
    (and (<= x1 x2) (<= y1 y2)))

  (define (check-rect x1 y1 x2 y2)
    (and (valid? x1 y1 x2 y2)
         (for/and ([r (in-list rectangles)])
           (let ([x (car r)] [y (cadr r)])
             (and (<= x1 x x2) (<= y1 y y2))))))

  (define (helper rects)
    (cond [(null? rects) 0]
          [else
           (let* ([r (car rects)]
                  [x1 (car r)]
                  [y1 (cadr r)]
                  [x2 (caddr r)]
                  [y2 (cadddr r)])
             (max (if (check-rect x1 y1 x2 y2)
                      (area x1 y1 x2 y2)
                      0)
                  (helper (cdr rects))))]))

  (helper rectangles))