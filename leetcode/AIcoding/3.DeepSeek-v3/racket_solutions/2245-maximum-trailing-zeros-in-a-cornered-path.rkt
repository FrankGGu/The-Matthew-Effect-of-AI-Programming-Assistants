#lang racket

(define (max-trailing-zeros grid)
  (define m (length grid))
  (define n (length (car grid)))

  (define (factor x k)
    (let loop ([x x] [cnt 0])
      (if (zero? (remainder x k))
          (loop (quotient x k) (add1 cnt))
          cnt)))

  (define (get-factors x)
    (list (factor x 2) (factor x 5)))

  (define (add-factors a b)
    (list (+ (car a) (car b)) (+ (cadr a) (cadr b)))

  (define (min-zeros a)
    (min (car a) (cadr a)))

  (define (build-prefix)
    (define prefix (make-vector m))
    (for ([i (in-range m)])
      (vector-set! prefix i (make-vector n)))
    (for ([i (in-range m)])
      (for ([j (in-range n)])
        (define val (get-factors (list-ref (list-ref grid i) j)))
        (define up (if (> i 0) (vector-ref (vector-ref prefix (- i 1)) j) (list 0 0)))
        (define left (if (> j 0) (vector-ref (vector-ref prefix i) (- j 1)) (list 0 0)))
        (vector-set! (vector-ref prefix i) j (add-factors val (add-factors up left)))))
    prefix)

  (define prefix (build-prefix))

  (define (query i1 j1 i2 j2)
    (define total (vector-ref (vector-ref prefix i2) j2))
    (define up (if (> i1 0) (vector-ref (vector-ref prefix (- i1 1)) j2) (list 0 0)))
    (define left (if (> j1 0) (vector-ref (vector-ref prefix i2) (- j1 1)) (list 0 0)))
    (define overlap (if (and (> i1 0) (> j1 0)) (vector-ref (vector-ref prefix (- i1 1)) (- j1 1)) (list 0 0)))
    (add-factors (add-factors total overlap) (add-factors (map - up) (map - left)))))

  (define max-zeros 0)
  (for ([i (in-range m)])
    (for ([j (in-range n)])
      (define top-left (query 0 0 i j))
      (define top-right (query 0 j i (- n 1)))
      (define bottom-left (query i 0 (- m 1) j))
      (define bottom-right (query i j (- m 1) (- n 1)))
      (set! max-zeros (max max-zeros 
                           (min-zeros top-left)
                           (min-zeros top-right)
                           (min-zeros bottom-left)
                           (min-zeros bottom-right)))))
  max-zeros)