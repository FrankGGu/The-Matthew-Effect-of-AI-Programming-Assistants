#lang racket

(define (count-submatrices grid)
  (define m (length grid))
  (define n (length (car grid)))

  (define px-sums (build-list (+ m 1) (lambda (_) (make-vector (+ n 1) 0))))
  (define py-sums (build-list (+ m 1) (lambda (_) (make-vector (+ n 1) 0))))

  (define count 0)

  (for* ([r (in-range m)]
         [c (in-range n)])
    (define current-char (list-ref (list-ref grid r) c))

    (define x-val (if (char=? current-char #\X) 1 0))
    (define y-val (if (char=? current-char #\Y) 1 0))

    (define px-row-r (list-ref px-sums r))
    (define px-row-r+1 (list-ref px-sums (+ r 1)))
    (define py-row-r (list-ref py-sums r))
    (define py-row-r+1 (list-ref py-sums (+ r 1)))

    (define prev-px-up (vector-ref px-row-r (+ c 1)))
    (define prev-px-left (vector-ref px-row-r+1 c))
    (define prev-px-diag (vector-ref px-row-r c))

    (define prev-py-up (vector-ref py-row-r (+ c 1)))
    (define prev-py-left (vector-ref py-row-r+1 c))
    (define prev-py-diag (vector-ref py-row-r c))

    (define new-px (+ prev-px-up prev-px-left (- prev-px-diag) x-val))
    (define new-py (+ prev-py-up prev-py-left (- prev-py-diag) y-val))

    (vector-set! px-row-r+1 (+ c 1) new-px)
    (vector-set! py-row-r+1 (+ c 1) new-py)

    (when (and (= new-px new-py) (> new-px 0))
      (set! count (+ count 1))))

  count)