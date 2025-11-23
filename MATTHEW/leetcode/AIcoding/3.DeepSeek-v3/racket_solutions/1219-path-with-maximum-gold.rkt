#lang racket

(define (get-maximum-gold grid)
  (define rows (length grid))
  (define cols (if (null? grid) 0 (length (car grid))))
  (define max-gold 0)

  (define (dfs i j current)
    (if (or (< i 0) (>= i rows) (< j 0) (>= j cols) (zero? (list-ref (list-ref grid i) j)))
        current
        (let* ([gold (list-ref (list-ref grid i) j)]
               [new-current (+ current gold)]
               [temp (list-ref (list-ref grid i) j)]
               [new-grid (for/list ([r (in-range rows)])
                           (for/list ([c (in-range cols)])
                             (if (and (= r i) (= c j)) 0 (list-ref (list-ref grid r) c))))])
          (set! (list-ref (list-ref grid i) j) 0)
          (define up (dfs (- i 1) j new-current))
          (define down (dfs (+ i 1) j new-current))
          (define left (dfs i (- j 1) new-current))
          (define right (dfs i (+ j 1) new-current))
          (set! (list-ref (list-ref grid i) j) temp)
          (max up down left right))))

  (for ([i (in-range rows)])
    (for ([j (in-range cols)])
      (when (not (zero? (list-ref (list-ref grid i) j)))
        (set! max-gold (max max-gold (dfs i j 0))))))
  max-gold)