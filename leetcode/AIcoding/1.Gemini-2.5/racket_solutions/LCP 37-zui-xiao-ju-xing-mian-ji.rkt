(require racket/hash)

(define (min-area-rect points)
  (define point-set (make-hash-set))
  (for-each (lambda (p) (hash-set-add! point-set (cons (car p) (cadr p)))) points)

  (define min-area +inf.0)
  (define n (length points))

  (for ([i (in-range n)])
    (define p1-list (list-ref points i))
    (define x1 (car p1-list))
    (define y1 (cadr p1-list))

    (for ([j (in-range (+ i 1) n)])
      (define p2-list (list-ref points j))
      (define x2 (car p2-list))
      (define y2 (cadr p2-list))

      (when (and (not (= x1 x2)) (not (= y1 y2)))
        (define p3 (cons x1 y2))
        (define p4 (cons x2 y1))

        (when (and (hash-set-member? point-set p3)
                   (hash-set-member? point-set p4))
          (define current-area (* (abs (- x1 x2)) (abs (- y1 y2))))
          (set! min-area (min min-area current-area))))))

  (if (eq? min-area +inf.0)
      0
      min-area))