(require racket/vector)
(require racket/for)

(define (max-value grid)
  (let* ([m (length grid)]
         [n (length (car grid))]
         [dp (make-vector m (lambda () (make-vector n 0)))])

    (define (get-grid i j)
      (list-ref (list-ref grid i) j))

    (define (set-dp i j val)
      (vector-set! (vector-ref dp i) j val))

    (define (get-dp i j)
      (vector-ref (vector-ref dp i) j))

    (set-dp 0 0 (get-grid 0 0))

    (for ([j (in-range 1 n)])
      (set-dp 0 j (+ (get-grid 0 j) (get-dp 0 (- j 1)))))

    (for ([i (in-range 1 m)])
      (set-dp i 0 (+ (get-grid i 0) (get-dp (- i 1) 0))))

    (for ([i (in-range 1 m)])
      (for ([j (in-range 1 n)])
        (let* ([val-grid (get-grid i j)]
               [val-up (get-dp (- i 1) j)]
               [val-left (get-dp i (- j 1))])
          (set-dp i j (+ val-grid (max val-up val-left))))))

    (get-dp (- m 1) (- n 1))))