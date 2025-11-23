#lang racket

(require racket/hash)
(require racket/math)

(define (min-area-rect points)
  (define point-set (make-hash-set))

  (for-each (lambda (p)
              (hash-set-add! point-set (cons (first p) (second p))))
            points)

  (define min-area +inf.0)

  (for ([p1 points])
    (define x1 (first p1))
    (define y1 (second p1))

    (for ([p2 points])
      (define x2 (first p2))
      (define y2 (second p2))

      (when (and (not (= x1 x2)) (not (= y1 y2)))
        (define p3-key (cons x1 y2))
        (define p4-key (cons x2 y1))

        (when (and (hash-set-contains? point-set p3-key)
                   (hash-set-contains? point-set p4-key))

          (define current-area (* (abs (- x2 x1)) (abs (- y2 y1))))
          (set! min-area (min min-area current-area))))))

  (if (= min-area +inf.0)
      0
      min-area))