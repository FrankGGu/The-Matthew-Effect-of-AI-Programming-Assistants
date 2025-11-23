(define (make-dsu n)
  (define parents (make-vector n))
  (define ranks (make-vector n 0))
  (for ([i (in-range n)])
    (vector-set! parents i i))
  (list parents ranks))

(define (find dsu i)
  (define parents (car dsu))
  (let loop ([curr i])
    (let ([p (vector-ref parents curr)])
      (if (= p curr)
          curr
          (begin
            (vector-set! parents curr (find dsu p))
            (vector-ref parents curr))))))

(define (union dsu i j)
  (define parents (car dsu))
  (define ranks (cadr dsu))
  (let ([root-i (find dsu i)]
        [root-j (find dsu j)])
    (unless (= root-i root-j)
      (let ([rank-i (vector-ref ranks root-i)]
            [rank-j (vector-ref ranks root-j)])
        (cond
          ((< rank-i rank-j) (vector-set! parents root-i root-j))
          ((> rank-i rank-j) (vector-set! parents root-j root-i))
          (else
           (vector-set! parents root-j root-i)
           (vector-set! ranks root-i (+ rank-i 1))))))))

(define (sqr x) (* x x))

(define (check-if-rectangle-corner-is-reachable x1 y1 x2 y2 circles)
  (define num-circles (length circles))
  (define num-nodes (+ num-circles 4))
  (define dsu (make-dsu num-nodes))

  (define left-wall-idx num-circles)
  (define right-wall-idx (+ num-circles 1))
  (define bottom-wall-idx (+ num-circles 2))
  (define top-wall-idx (+ num-circles 3))

  (for ([i (in-range num-circles)])
    (define circle-i (list-ref circles i))
    (define cx-i (list-ref circle-i 0))
    (define cy-i (list-ref circle-i 1))
    (define r-i (list-ref circle-i 2))

    (for ([j (in-range (+ i 1) num-circles)])
      (define circle-j (list-ref circles j))
      (define cx-j (list-ref circle-j 0))
      (define cy-j (list-ref circle-j 1))
      (define r-j (list-ref circle-j 2))

      (define dx (- cx-i cx-j))
      (define dy (- cy-i cy-j))
      (define dist-sq (+ (sqr dx) (sqr dy)))
      (define r-sum-sq (sqr (+ r-i r-j)))

      (when (<= dist-sq r-sum-sq)
        (union dsu i j))))

  (for ([i (in-range num-circles)])
    (define circle-i (list-ref circles i))
    (define cx-i (list-ref circle-i 0))
    (define cy-i (list-ref circle-i 1))
    (define r-i (list-ref circle-i 2))

    (when (<= (- cx-i r-i) x1) (union dsu i left-wall-idx))
    (when (>= (+ cx-i r-i) x2) (union dsu i right-wall-idx))
    (when (<= (- cy-i r-i) y1) (union dsu i bottom-wall-idx))
    (when (>= (+ cy-i r-i) y2) (union dsu i top-wall-idx)))

  (define left-root (find dsu left-wall-idx))
  (define right-root (find dsu right-wall-idx))
  (define bottom-root (find dsu bottom-wall-idx))
  (define top-root (find dsu top-wall-idx))

  (and (not (= left-root right-root))
       (not (= bottom-root top-root))))