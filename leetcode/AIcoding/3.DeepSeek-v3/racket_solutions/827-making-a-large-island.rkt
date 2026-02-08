#lang racket

(define (largest-island grid)
  (define rows (length grid))
  (define cols (if (null? grid) 0 (length (car grid))))
  (define color 2)
  (define color-area (make-hash))
  (define max-area 0)

  (define (dfs r c)
    (cond [(or (< r 0) (>= r rows) (< c 0) (>= c cols)) 0]
          [(not (= (list-ref (list-ref grid r) c) 1)) 0]
          [else 
           (list-set! (list-ref grid r) c color)
           (add1 (+ (dfs (add1 r) c)
                    (dfs (sub1 r) c)
                    (dfs r (add1 c))
                    (dfs r (sub1 c))))]))

  (for ([r (in-range rows)])
    (for ([c (in-range cols)])
      (when (= (list-ref (list-ref grid r) c) 1)
        (hash-set! color-area color (dfs r c))
        (set! max-area (max max-area (hash-ref color-area color)))
        (set! color (add1 color)))))

  (for ([r (in-range rows)])
    (for ([c (in-range cols)])
      (when (= (list-ref (list-ref grid r) c) 0)
        (define neighbors (mutable-set))
        (for ([dr (in-list '(-1 1 0 0))]
              [dc (in-list '(0 0 -1 1))])
          (define nr (+ r dr))
          (define nc (+ c dc))
          (when (and (>= nr 0) (< nr rows) (>= nc 0) (< nc cols))
                     (> (list-ref (list-ref grid nr) nc) 1))
            (set-add! neighbors (list-ref (list-ref grid nr) nc)))
        (define area 1)
        (for ([col (in-set neighbors)])
          (set! area (+ area (hash-ref color-area col))))
        (set! max-area (max max-area area)))))
  max-area)