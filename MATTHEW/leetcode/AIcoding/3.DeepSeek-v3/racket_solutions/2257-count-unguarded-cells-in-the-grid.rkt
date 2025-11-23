#lang racket

(define (count-unguarded m n guards walls)
  (define grid (make-vector m (make-vector n 0)))
  (define (set-cell! i j val)
    (vector-set! (vector-ref grid i) j val))
  (define (get-cell i j)
    (vector-ref (vector-ref grid i) j))

  (for ([g guards])
    (let ([i (car g)]
          [j (cadr g)])
      (set-cell! i j 'G)))

  (for ([w walls])
    (let ([i (car w)]
          [j (cadr w)])
      (set-cell! i j 'W)))

  (define directions '((0 . 1) (1 . 0) (0 . -1) (-1 . 0)))

  (for ([g guards])
    (let ([i (car g)]
          [j (cadr g)])
      (for ([dir directions])
        (let ([di (car dir)]
              [dj (cdr dir)])
          (let loop ([ni (+ i di)]
                     [nj (+ j dj)])
            (when (and (>= ni 0) (< ni m) (>= nj 0) (< nj n))
              (let ([cell (get-cell ni nj)])
                (cond
                  [(or (eq? cell 'G) (eq? cell 'W)) (void)]
                  [(eq? cell 'U) (loop (+ ni di) (+ nj dj))]
                  [else
                   (set-cell! ni nj 'U)
                   (loop (+ ni di) (+ nj dj))])))))))

  (define count 0)
  (for ([i (in-range m)])
    (for ([j (in-range n)])
      (when (eq? (get-cell i j) 0)
        (set! count (add1 count)))))
  count)