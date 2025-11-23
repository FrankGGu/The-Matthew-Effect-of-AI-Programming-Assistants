#lang racket

(define (shortest-bridge grid)
  (define n (length grid))
  (define directions '((0 1) (1 0) (0 -1) (-1 0)))
  (define visited (make-vector n #f))
  (define (dfs i j)
    (vector-set! visited i #t)
    (for-each (lambda (d)
                (let ([ni (+ i (car d))][nj (+ j (cadr d))])
                  (when (and (<= 0 ni (- n 1)) (<= 0 nj (- n 1)) (not (vector-ref visited ni)) (= (list-ref (list-ref grid ni) nj) 1)))
                    (dfs ni nj))))
              directions))
  (define (bfs q)
    (define (loop q dist)
      (if (null? q)
          dist
          (let ([current (car q)])
            (let ([i (car current)][j (cadr current)][d (caddr current)])
              (for-each (lambda (d)
                          (let ([ni (+ i (car d))][nj (+ j (cadr d))])
                            (when (and (<= 0 ni (- n 1)) (<= 0 nj (- n 1)) (not (vector-ref visited ni)))
                              (if (= (list-ref (list-ref grid ni) nj) 1)
                                  (add1 dist)
                                  (begin
                                    (vector-set! visited ni #t)
                                    (loop (append (cdr q) (list (list ni nj d))) dist))))))
                        directions)))))
    (loop q 0))
  (let loop ([i 0])
    (if (>= i n)
        #f
        (let ([j (let loop2 ([j 0])
                   (if (>= j n)
                       #f
                       (if (= (list-ref (list-ref grid i) j) 1)
                           j
                           (loop2 (+ j 1)))))]
              (if j #f #t))
          (begin
            (vector-set! visited i #t)
            (dfs i j)
            (bfs (list (list i j 0))))
          (loop (+ i 1))))))