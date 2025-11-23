#lang racket

(define (count-factors n factor)
  (let loop ((num n) (count 0))
    (if (zero? (remainder num factor))
        (loop (/ num factor) (+ count 1))
        count)))

(define (get-factors n)
  (list (count-factors n 2) (count-factors n 5)))

(define (max-trailing-zeros grid-list)
  (define M (length grid-list))
  (define N (length (car grid-list)))

  (define grid (build-vector M (lambda (r) (list->vector (list-ref grid-list r)))))

  (define factors-grid
    (build-vector M
      (lambda (r)
        (build-vector N
          (lambda (c)
            (get-factors (vector-ref (vector-ref grid r) c)))))))

  (define up (build-vector M (lambda (r) (build-vector N (lambda (c) (list 0 0))))))
  (define left (build-vector M (lambda (r) (build-vector N (lambda (c) (list 0 0))))))
  (define down (build-vector M (lambda (r) (build-vector N (lambda (c) (list 0 0))))))
  (define right (build-vector M (lambda (r) (build-vector N (lambda (c) (list 0 0))))))

  (for* ((r (in-range M))
         (c (in-range N)))
    (define curr-f (vector-ref (vector-ref factors-grid r) c))
    (define prev-up (if (> r 0) (vector-ref (vector-ref up (- r 1)) c) (list 0 0)))
    (define prev-left (if (> c 0) (vector-ref (vector-ref left r) (- c 1)) (list 0 0)))
    (vector-set! (vector-ref up r) c (map + prev-up curr-f))
    (vector-set! (vector-ref left r) c (map + prev-left curr-f)))

  (for* ((r (in-range (- M 1) -1 -1))
         (c (in-range (- N 1) -1 -1)))
    (define curr-f (vector-ref (vector-ref factors-grid r) c))
    (define prev-down (if (< r (- M 1)) (vector-ref (vector-ref down (+ r 1)) c) (list 0 0)))
    (define prev-right (if (< c (- N 1)) (vector-ref (vector-ref right r) (+ c 1)) (list 0 0)))
    (vector-set! (vector-ref down r) c (map + prev-down curr-f))
    (vector-set! (vector-ref right r) c (map + prev-right curr-f)))

  (define max-zeros 0)

  (for* ((r (in-range M))
         (c (in-range N)))
    (define curr-f (vector-ref (vector-ref factors-grid r) c))
    (define f2 (car curr-f))
    (define f5 (cdr curr-f))

    (define u-val (vector-ref (vector-ref up r) c))
    (define d-val (vector-ref (vector-ref down r) c))
    (define l-val (vector-ref (vector-ref left r) c))
    (define r-val (vector-ref (vector-ref right r) c))

    (define u2 (car u-val)) (define u5 (cdr u-val))
    (define d2 (car d-val)) (define d5 (cdr d-val))
    (define l2 (car l-val)) (define l5 (cdr l-val))
    (define r2 (car r-val)) (define r5 (cdr r-val))

    ;; Path type 1: vertical segment from top to (r,c) + horizontal segment from left to (r,c)
    ;; Requires r > 0 and c > 0 for distinct cells.
    (when (and (> r 0) (> c 0))
      (define total-c2 (+ u2 l2 (- f2)))
      (define total-c5 (+ u5 l5 (- f5)))
      (set! max-zeros (max max-zeros (min total-c2 total-c5))))

    ;; Path type 2: vertical segment from top to (r,c) + horizontal segment from (r,c) to right
    ;; Requires r > 0 and c < N-1 for distinct cells.
    (when (and (> r 0) (< c (- N 1)))
      (define total-c2 (+ u2 r2 (- f2)))
      (define total-c5 (+ u5 r5 (- f5)))
      (set! max-zeros (max max-zeros (min total-c2 total-c5))))

    ;; Path type 3: vertical segment from bottom to (r,c) + horizontal segment from left to (r,c)
    ;; Requires r < M-1 and c > 0 for distinct cells.
    (when (and (< r (- M 1)) (> c 0))
      (define total-c2 (+ d2 l2 (- f2)))
      (define total-c5 (+ d5 l5 (- f5)))
      (set! max-zeros (max max-zeros (min total-c2 total-c5))))

    ;; Path type 4: vertical segment from bottom to (r,c) + horizontal segment from (r,c) to right
    ;; Requires r < M-1 and c < N-1 for distinct cells.
    (when (and (< r (- M 1)) (< c (- N 1)))
      (define total-c2 (+ d2 r2 (- f2)))
      (define total-c5 (+ d5 r5 (- f5)))
      (set! max-zeros (max max-zeros (min total-c2 total-c5)))))

  max-zeros)