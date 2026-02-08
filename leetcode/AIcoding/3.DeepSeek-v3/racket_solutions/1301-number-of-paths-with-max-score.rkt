#lang racket

(define (paths-with-max-score board)
  (define n (length board))
  (define m (if (zero? n) 0 (length (car board))))

  (define dp (make-vector n (make-vector m '(0 . 0))))

  (for ([i (in-range n)])
    (for ([j (in-range m)])
      (vector-set! (vector-ref dp i) j '(0 . 0))))

  (vector-set! (vector-ref dp (- n 1)) (- m 1) '(0 . 1))

  (for ([i (in-range (- n 1) -1 -1)])
    (for ([j (in-range (- m 1) -1 -1)])
      (define cell (list-ref (list-ref board i) j))
      (when (and (equal? i (- n 1)) (equal? j (- m 1)))
        (vector-set! (vector-ref dp i) j '(0 . 1))
        (continue))

      (when (char=? cell #\X)
        (vector-set! (vector-ref dp i) j '(0 . 0))
        (continue))

      (define max-score 0)
      (define count 0)

      (for ([dir (in-list '((1 . 0) (0 . 1) (1 . 1)))])
        (define ni (+ i (car dir)))
        (define nj (+ j (cdr dir)))
        (when (and (< ni n) (< nj m))
          (define val (vector-ref (vector-ref dp ni) nj))
          (define s (car val))
          (define c (cdr val))
          (when (> s max-score)
            (set! max-score s)
            (set! count c))
          (when (= s max-score)
            (set! count (+ count c))))

      (define current (if (char=? cell #\E) 0 (- (char->integer cell) (char->integer #\0))))
      (define total (+ max-score current))
      (vector-set! (vector-ref dp i) j (cons total (modulo count 1000000007)))))

  (define res (vector-ref (vector-ref dp 0) 0))
  (if (zero? (cdr res))
      '(0 . 0)
      res))